resource "aws_vpc" "vpc_public" {
  cidr_block       = "172.33.0.0/16"
  enable_dns_support = true
  enable_dns_hostnames = true

   tags = {
    Name = "public VPC"
  }
}

resource "aws_subnet" "vpc_public_subnet_public_1" {
  vpc_id     = aws_vpc.vpc_public.id
  cidr_block = "172.33.0.0/20"
  availability_zone = var.availability_zone

  tags = {
    Name = "pocdemo-subnet-public1-us-east-1a"
  }
}

resource "aws_subnet" "vpc_public_subnet_public_1" {
  vpc_id     = aws_vpc.vpc_public.id
  cidr_block = "172.33.16.0/20"
  availability_zone = var.availability_zone2

  tags = {
    Name = "pocdemo-subnet-public2-us-east1b"
  }
}
