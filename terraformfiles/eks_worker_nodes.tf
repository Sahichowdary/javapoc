resource "aws_eks_node_group" "eks_poc_main" {
  cluster_name = aws_eks_cluster.eks_poc_main.name
  node_role_arn = var.eks_node_role
  subnet_ids = [aws_subnet.vpc_private_subnet_private_1.id, aws_subnet.vpc_private_subnet_private_2.id, aws_subnet.vpc_private_subnet_private_3.id, aws_subnet.vpc_private_subnet_private_4.id]
  scaling_config {
    min_size = 3
    max_size = 5
    desired_size = 3
  }
  instance_types = ["t3a.medium"]
  capacity_type  = "ON_DEMAND"    # or SPOT
  disk_size       = 20             # in GB
  version = "1.29"
  #release_version = "xxx"
  remote_access {
    ec2_ssh_key = "aws-poc-demo"
  }
  depends_on = [
    aws_iam_role_policy_attachment.AmazonEKSWorkerNodePolicy
  ]
}

resource "aws_eks_node_group_update_config" "node_group_update" {
  cluster_name    = aws_eks_cluster.eks_poc_main.name
  node_group_name = aws_eks_node_group.eks_poc_main.name
  version         = "1.29"  # The Kubernetes version for which to enable auto-upgrades

  enabled    = true
  wait_for_completion = true
}
