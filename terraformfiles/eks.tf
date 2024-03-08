resource "aws_eks_cluster" "eks_poc_main" {
  name     = "ekspocdemo1"
  role_arn = var.eks_cluster_role

  vpc_config {
    endpoint_public_access = false
    endpoint_private_access = true
    subnet_ids = [aws_subnet.vpc_private_subnet_private_1.id, aws_subnet.vpc_private_subnet_private_2.id, aws_subnet.vpc_private_subnet_private_3.id, aws_subnet.vpc_private_subnet_private_4.id]
  }
  
  version = "1.29"

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
