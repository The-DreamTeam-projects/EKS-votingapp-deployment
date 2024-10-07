# Reference existing IAM role (jenkins-role) by its ARN
resource "aws_eks_cluster" "my_cluster" {
  name     = var.cluster_name
  role_arn = "arn:aws:iam::058264135500:role/jenkins-role"  # Replace with your jenkins-role ARN

  vpc_config {
    subnet_ids = aws_subnet.public.*.id
  }

  tags = {
    Name = var.cluster_name
  }
}

# Attach the existing role to required policies
resource "aws_iam_role_policy_attachment" "eks_cluster_managed" {
  role       = "jenkins-role"  # Existing role
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
}

# Node group resources as previously defined
resource "aws_iam_role" "eks_node" {
  name = "eks-node-role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      },
    ]
  })
}

# Rest of the IAM policies and attachments...
resource "aws_iam_role_policy_attachment" "eks_node" {
  role       = aws_iam_role.eks_node.name
  policy_arn = aws_iam_policy.eks_node_policy.arn
}

resource "aws_iam_role_policy_attachment" "eks_node_managed" {
  role       = aws_iam_role.eks_node.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
}

resource "aws_iam_role_policy_attachment" "eks_node_cni" {
  role       = aws_iam_role.eks_node.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
}

resource "aws_iam_role_policy_attachment" "eks_node_ec2_container_registry" {
  role       = aws_iam_role.eks_node.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
}
