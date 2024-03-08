resource "aws_eks_cluster" "eks_poc_main" {
  name     = "ekspocdemo"
  role_arn = var.eks_cluster_role
  version = "1.29"

  vpc_config {
    endpoint_public_access = false
    endpoint_private_access = true
    subnet_ids = [aws_subnet.vpc_private_subnet_private_1.id, aws_subnet.vpc_private_subnet_private_2.id, aws_subnet.vpc_private_subnet_private_3.id, aws_subnet.vpc_private_subnet_private_4.id]
    security_group_ids = [aws_security_group.eks_cluster_sg.id]  
}
  enabled_cluster_log_types = [
    "api",
    "audit",
    "authenticator",
    "controllerManager",
    "scheduler"
  ]

  encryption_config {
    resources = ["secrets"]
    provider {

        key_arn = var.eks_encryption_key
    }
  }

  depends_on = [
    aws_iam_role.EKSClusterRole,
    aws_iam_role.AmazonEKSNodeRole
  ]
}

resource "aws_eks_cluster_auth" "my_cluster_auth" {
  name = aws_eks_cluster.my_cluster.name

  depends_on = [
    aws_eks_cluster.eks_poc_main,
  ]
}

resource "aws_eks_cluster_update_config" "cluster_update" {
  name       = aws_eks_cluster.eks_poc_main.name
  version    = "1.29"  # The Kubernetes version for which to enable auto-upgrades
  enabled    = true
  wait_for_completion = true
}
