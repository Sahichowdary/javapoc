resource "aws_eks_node_group" "eks_main" {
  cluster_name = aws_eks_cluster.eks_main.name
  node_role_arn = var.eks_node_role
  subnet_ids = [aws_subnet.vpc_private_subnet_private_1.id, aws_subnet.vpc_private_subnet_private_2.id]
  scaling_config {
    min_size = 1
    max_size = 3
    desired_size = 2
  }
  instance_types = ["t3a.medium"]
  version = "1.29"
  #release_version = "xxx"
}
