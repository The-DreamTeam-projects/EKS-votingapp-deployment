# EKS Deployment

This repository contains files for deploying a voting application and a MySQL database to an Amazon EKS cluster using Jenkins.

## Prerequisites

- AWS account with necessary IAM roles and permissions.
- DockerHub account (with images for MySQL and the voting application).
- Jenkins instance with the AWS Credentials Plugin installed.
- Kubernetes cluster (EKS) with kubectl and eksctl configured.

## Setup

### Clone the Repository

```sh
git clone https://github.com/<your-username>/EKS-deployment.git
cd EKS-deployment

Step 1: Create an IAM User or Role
Create an IAM User
Sign in to the AWS Management Console.

Navigate to the IAM console.
Create a new user:    #in this case we are working as root user though

Go to Users and click Add user.
Enter a username (e.g., jenkins-user).
Select Programmatic access.
Attach policies:

Attach the following managed policies:
AmazonEKSClusterPolicy
AmazonEKSWorkerNodePolicy
AmazonEC2ContainerRegistryFullAccess   #in this case we are using dockerhub though
AmazonS3FullAccess
AmazonEC2FullAccess
IAMFullAccess
Optionally, create a custom policy to restrict permissions further based on your security requirements.
Complete the user creation and download the access key ID and secret access key. You will use these credentials in Jenkins.

Create an IAM Role (if using EC2 Jenkins Agent)
Navigate to the IAM console.

Create a new role:
Go to Roles and click Create role.
Select AWS service and choose EC2.
Attach the same managed policies as mentioned above.
Complete the role creation.
Attach the role to your Jenkins EC2 instance:

Navigate to the EC2 console.
Select your Jenkins instance.
Choose Actions > Instance Settings > Attach/Replace IAM Role.
Select the newly created IAM role and attach it.
Step 2: Configure Jenkins to Use AWS Credentials
Using AWS Credentials in Jenkins
Install the AWS Credentials Plugin:

In Jenkins, navigate to Manage Jenkins > Manage Plugins.
Go to the Available tab, search for AWS Credentials Plugin, and install it.
Add AWS credentials:

In Jenkins, navigate to Manage Jenkins > Manage Credentials.
Select the appropriate domain (e.g., Global).
Click Add Credentials and select AWS Credentials from the kind dropdown.
Enter the access key ID and secret access key obtained when creating the IAM user.
Give it an ID (e.g., aws-credentials) and a description.
Save the credentials.

Ensure Jenkins is set up and has the necessary plugins installed (Kubernetes CLI Plugin, Pipeline: AWS Steps, Pipeline: Groovy, etc.)
Configure Jenkins and Run the Pipeline
Add AWS Credentials in Jenkins:

Add your AWS credentials in Jenkins (aws-credentials).
Update the Jenkinsfile with your DockerHub credentials and image names.
Create a secret in your Kubernetes cluster for DockerHub (if using private repositories)

Go to Jenkins Dashboard -> Manage Jenkins -> Manage Credentials.
Add a new credential of type "AWS Credentials" and name it aws-credentials.
Create a Jenkins Pipeline Job:

Go to Jenkins Dashboard -> New Item -> Pipeline.
Name the job (e.g., EKS-deployment-pipeline).
In the "Pipeline" section, select "Pipeline script from SCM".
Set "SCM" to "Git".
Enter your repository URL (e.g., https://github.com/<your-username>/EKS-deployment.git).
Click "Save".
Run the Pipeline:



Step 1: Install the AWS Credentials Plugin
Go to Jenkins Dashboard.
Click on "Manage Jenkins".
Click on "Manage Plugins".
Go to the "Available" tab.
Search for "AWS Credentials Plugin".
Install the plugin and restart Jenkins if required.

Step 2: Add AWS Credentials to Jenkins
Go to Jenkins Dashboard.
Click on "Manage Jenkins".
Click on "Manage Credentials".
Select the appropriate domain (e.g., "Global credentials (unrestricted)").
Click on "Add Credentials".
Choose "AWS Credentials" as the kind.
Enter the AWS Access Key ID and Secret Access Key
Give the credentials an ID (e.g., aws-credentials)

Update your Jenkinsfile to use the AWS credentials and configure the AWS CLI


Step 3: Add DockerHub Credentials to Jenkins
If your DockerHub images are private, you'll need to add DockerHub credentials to Jenkins as well.
Go to Jenkins Dashboard.
Click on "Manage Jenkins".
Click on "Manage Credentials".
Select the appropriate domain (e.g., "Global credentials (unrestricted)").
Click on "Add Credentials".
Choose "Username with password" as the kind.
Enter your DockerHub username and password.
Give the credentials an ID (e.g., dockerhub-credentials)

Step 4: Create DockerHub Secret in Kubernetes
Ensure that your Jenkinsfile includes the step to create a secret in your Kubernetes cluster for DockerHub
Ensure the DockerHub secret is created in the same namespace where the deployments are applied.
stage('Create DockerHub Secret') {
    steps {
        sh '''
        kubectl create secret docker-registry dockerhub-secret \
        --docker-server=https://index.docker.io/v1/ \
        --docker-username=<your-dockerhub-username> \
        --docker-password=<your-dockerhub-password> \
        --docker-email=<your-email> \
        --namespace=${NAMESPACE} || true
        '''
    }
}

step 5: Add MySQL Root Password to Jenkins Credentials
Go to Jenkins Dashboard.
Click on "Manage Jenkins".
Click on "Manage Credentials".
Select the appropriate domain (e.g., "Global credentials (unrestricted)").
Click on "Add Credentials".
Choose "Secret text" as the kind.
Enter the MySQL root password.
Give the credentials an ID (e.g., mysql-root-password).

