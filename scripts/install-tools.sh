# #!/bin/bash

# # Define installation paths
# INSTALL_DIR=$HOME/bin
# mkdir -p $INSTALL_DIR

# # Update PATH
# export PATH=$INSTALL_DIR:$PATH

# # Install eksctl
# curl --silent --location "https://github.com/weaveworks/eksctl/releases/latest/download/eksctl_$(uname -s)_amd64.tar.gz" | tar xz -C /tmp
# mv /tmp/eksctl $INSTALL_DIR/eksctl
# eksctl version

# # Install kubectl
# curl -O https://s3.us-west-2.amazonaws.com/amazon-eks/1.31.0/2024-09-12/bin/linux/amd64/kubectl
# chmod +x ./kubectl
# mkdir -p $HOME/bin && cp ./kubectl $HOME/bin/kubectl && export PATH=$HOME/bin:$PATH
# echo 'export PATH=$HOME/bin:$PATH' >> ~/.bashrc
# kubectl version --client

# Install AWS CLI
# curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
# sudo apt install unzip -y
# unzip awscliv2.zip
# sudo ./aws/install
# ./aws/install --bin-dir $INSTALL_DIR --install-dir $INSTALL_DIR/aws-cli --update
# aws --version

# # Install Terraform
# wget -O- https://apt.releases.hashicorp.com/gpg | sudo gpg --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg
# echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/hashicorp.list
# sudo apt update && sudo apt install terraform
# terraform --version

# # Cleanup
# rm -f kubectl awscliv2.zip terraform.zip
# rm -rf aws

# echo "All tools installed successfully!"

# # Verification

# # Verify eksctl installation
# if command -v eksctl &> /dev/null; then
#     echo "eksctl version: $(eksctl version)"
# else
#     echo "eksctl is not installed correctly."
# fi

# # Verify kubectl installation
# if command -v kubectl &> /dev/null; then
#     echo "kubectl version: $(kubectl version --client)"
# else
#     echo "kubectl is not installed correctly."
# fi

# # Verify AWS CLI installation
# if command -v aws &> /dev/null; then
#     echo "AWS CLI version: $(aws --version)"
# else
#     echo "AWS CLI is not installed correctly."
# fi

# # Verify Terraform installation
# if command -v terraform &> /dev/null; then
#     echo "Terraform version: $(terraform -version)"
# else
#     echo "Terraform is not installed correctly."
# fi

# # Verify Docker installation
# if command -v docker &> /dev/null; then
#     echo "Docker version: $(docker --version)"
# else
#     echo "Docker is not installed correctly."
# fi
