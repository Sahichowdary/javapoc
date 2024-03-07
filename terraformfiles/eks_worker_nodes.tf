resource "aws_eks_node_group" "eks_main" {
  cluster_name = aws_eks_cluster.eks_main.name
  node_role_arn = var.eks_node_role
  subnet_ids = [aws_subnet.vpc_private_subnet_private_1.id, aws_subnet.vpc_private_subnet_private_2.id, aws_subnet.vpc_private_subnet_private_3.id, aws_subnet.vpc_private_subnet_private_4.id, aws_subnet.vpc_private_subnet_private_5.id, aws_subnet.vpc_private_subnet_private_6.id]
  scaling_config {
    min_size = 3
    max_size = 5
    desired_size = 3
  }
  instance_types = ["t3a.medium"]
  version = "1.29"
  #release_version = "xxx"
  depends_on = [
    aws_iam_role_policy_attachment.eks_service_role_policy,
    aws_iam_role_policy_attachment.eks_node_group_role_policy,
    aws_iam_role_policy_attachment.eks_node_group_additional_policy,
    aws_eks_cluster.eks_main
  ]

}
