resource "aws_eks_node_group" "eks_main" {
  cluster_name = aws_eks_cluster.eks_main.name
  node_role_arn = aws_iam_role.NodeGroupRole-poc.arn
  subnet_ids = [aws_subnet.vpc_private_subnet_private_1.id, aws_subnet.vpc_private_subnet_private_2.id]
  scaling_config {
    min_size = 3
    max_size = 5
    desired_size = 3
  }
  instance_types = ["t3a.medium"]
  version = "1.29"
  #release_version = "xxx"

  depends_on = [
    aws_iam_role_policy_attachment.AmazonEKSWorkerNodePolicy-poc,
    aws_iam_role_policy_attachment.AmazonEC2ContainerRegistryReadOnly-poc,
    aws_iam_role_policy_attachment.AmazonEKS_CNI_Policy-poc
  ]
}
