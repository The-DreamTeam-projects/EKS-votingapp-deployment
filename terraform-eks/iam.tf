resource "aws_iam_role" "eks_cluster" {
  name = "jenkins-role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "eks.amazonaws.com"
        }
      },
    ]
  })
  tags = {
    Name = "jenkins-role"
  }
}

resource "aws_iam_policy" "eks_cluster_policy" {
  name        = "eks-cluster-policy"
  description = "EKS Cluster policy"
  policy      = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "ec2:DescribeSecurityGroups",
          "ec2:DescribeSubnets",
          "ec2:DescribeVpcs",
          "ec2:DescribeNetworkInterfaces",
          "ec2:CreateNetworkInterface",
          "ec2:CreateNetworkInterfacePermission",
          "ec2:DeleteNetworkInterface",
          "ec2:DeleteNetworkInterfacePermission",
          "ec2:AttachNetworkInterface"
        ]
        Effect   = "Allow"
        Resource = "*"
      },
    ]
  })
}

resource "aws_iam_role_policy_attachment" "eks_cluster" {
  role       = aws_iam_role.eks_cluster.name
  policy_arn = aws_iam_policy.eks_cluster_policy.arn
}

resource "aws_iam_role_policy_attachment" "eks_cluster_managed" {
  role       = aws_iam_role.eks_cluster.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
}

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

resource "aws_iam_policy" "eks_node_policy" {
  name        = "eks-node-policy"
  description = "EKS Node policy"
  policy      = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "ec2:DescribeInstances",
          "ec2:DescribeTags",
          "ec2:DescribeSecurityGroups",
          "ec2:DescribeSubnets",
          "ec2:DescribeVpcs",
          "logs:DescribeLogStreams",
          "logs:DescribeLogGroups",
          "logs:CreateLogStream",
          "logs:CreateLogGroup",
          "logs:PutLogEvents"
        ]
        Effect   = "Allow"
        Resource = "*"
      },
    ]
  })
}


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
