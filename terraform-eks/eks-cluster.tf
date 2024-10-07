resource "aws_eks_cluster" "my_cluster" {
name     = var.cluster_name
role_arn = "arn:aws:iam::058264135500:role/jenkins-role"
}

/*resource "aws_eks_cluster" "my_cluster" {
  name     = var.cluster_name
  role_arn  = aws_iam_role.eks_cluster.arn
  version   = "1.27"
*/

  vpc_config {
    subnet_ids = aws_subnet.public.*.id
  }

  tags = {
    Name = var.cluster_name
  }
}

resource "aws_eks_node_group" "my_node_group" {
  cluster_name    = aws_eks_cluster.my_cluster.name
  node_group_name = "my-node-group"
  node_role_arn   = aws_iam_role.eks_node.arn
  subnet_ids       = aws_subnet.public.*.id
  scaling_config {
    desired_size = 2
    max_size     = 2
    min_size     = 1
  }
  tags = {
    Name = "my-node-group"
  }
}

