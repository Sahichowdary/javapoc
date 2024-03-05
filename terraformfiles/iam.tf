resource "aws_iam_role" "EKSClusterRole-poc" {
  name = "EKSClusterRole"
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
}

resource "aws_iam_role" "NodeGroupRole-poc" {
  name = "EKSNodeGroupRole"
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

resource "aws_iam_role_policy_attachment" "AmazonEKSClusterPolicy-poc" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy-poc"
  role       = aws_iam_role.EKSClusterRole.name
}

resource "aws_iam_role_policy_attachment" "AmazonEKSWorkerNodePolicy-poc" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy-poc"
  role       = aws_iam_role.NodeGroupRole.name
}


resource "aws_iam_role_policy_attachment" "AmazonEC2ContainerRegistryReadOnly-poc" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly-poc"
  role       = aws_iam_role.NodeGroupRole.name
}

resource "aws_iam_role_policy_attachment" "AmazonEKS_CNI_Policy-poc" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy-poc"
  role       = aws_iam_role.NodeGroupRole.name
}
