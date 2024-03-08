data "aws_iam_policy_document" "assume_role" {
  statement {
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["eks.amazonaws.com"]
    }

    actions = ["sts:AssumeRole"]
  }
}
resource "aws_iam_role" "eks-iam-role" {
  name               = "eks-cluster-eks-poc-main"
  assume_role_policy = data.aws_iam_policy_document.assume_role.json
}
#Attaching AmazonEKSClusterPolicy to the  IAM role
resource "aws_iam_role_policy_attachment" "AmazonEKSClusterPolicy" {
 policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
 role    = aws_iam_role.eks-iam-role.name
}
 resource "aws_iam_role_policy_attachment" "AmazonEC2ContainerRegistryReadOnly-EKS" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
  role    = aws_iam_role.eks-iam-role.name
 }
#creating eks cluster
resource "aws_eks_cluster" "eks-poc-main" {
  name     = "Demo-POC"
  role_arn = aws_iam_role.eks-iam-role.arn
  version = "1.29"

  vpc_config {
    subnet_ids = [aws_subnet.vpc_private_subnet_private_1.id, aws_subnet.vpc_private_subnet_private_2.id, aws_subnet.vpc_private_subnet_private_3.id, aws_subnet.vpc_private_subnet_private_4.id]
  }

  # Ensure that IAM Role permissions are created before and deleted after EKS Cluster handling.
  # Otherwise, EKS will not be able to properly delete EKS managed EC2 infrastructure such as Security Groups.
  depends_on = [
    aws_iam_role_policy_attachment.AmazonEKSClusterPolicy,
    # aws_iam_role_policy_attachment.eks-poc-main-AmazonEKSVPCResourceController,
  ]
}
output "endpoint" {
  value = aws_eks_cluster.eks-poc-main.endpoint
}
#Creating IAM for Node group
resource "aws_iam_role" "eks-nodes" {
  name = "eks-node-group-role"

  assume_role_policy = jsonencode({
    Statement = [{
      Action = "sts:AssumeRole"
      Effect = "Allow"
      Principal = {
        Service = "ec2.amazonaws.com"
      }
    }]
    #Version = ""
  })
}
#Attaching AmazonEKSWorkerNodePolicy,AmazonEKS_CNI_Policy and AmazonEC2ContainerRegistryReadOnly to the IAM role
resource "aws_iam_role_policy_attachment" "eks-poc-main-AmazonEKSWorkerNodePolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
  role       = aws_iam_role.eks-nodes.name
}

resource "aws_iam_role_policy_attachment" "eks-poc-main-AmazonEKS_CNI_Policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
  role       =  aws_iam_role.eks-nodes.name
}

resource "aws_iam_role_policy_attachment" "eks-poc-main-AmazonEC2ContainerRegistryReadOnly" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
  role       =  aws_iam_role.eks-nodes.name
}
#creating node group for EKS
resource "aws_eks_node_group" "eks-node-group" {
  cluster_name    = aws_eks_cluster.eks-poc-main.name
  node_role_arn   = aws_iam_role.eks-nodes.arn
  subnet_ids      = [aws_subnet.vpc_private_subnet_private_1.id]

  scaling_config {
    desired_size = 3
    max_size     = 5
    min_size     = 3
  }

  update_config {
    max_unavailable = 1
  }

  # Ensure that IAM Role permissions are created before and deleted after EKS Node Group handling.
  # Otherwise, EKS will not be able to properly delete EC2 Instances and Elastic Network Interfaces.
  depends_on = [
    aws_iam_role_policy_attachment.eks-poc-main-AmazonEKSWorkerNodePolicy,
    aws_iam_role_policy_attachment.eks-poc-main-AmazonEKS_CNI_Policy,
    aws_iam_role_policy_attachment.eks-poc-main-AmazonEC2ContainerRegistryReadOnly,
  ]
}
