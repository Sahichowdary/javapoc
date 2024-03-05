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
    Name = "pocdemo-subnet-public1-us-west-2a"
  }
}

resource "aws_route_table" "public_vpc_route_table" {
  vpc_id = aws_vpc.vpc_public.id

  tags = {
    Name = "public Route table"
  }
}

resource "aws_route_table_association" "vpc_public_subnet_public_1_rtb_association" {
  subnet_id      = aws_subnet.vpc_public_subnet_public_1.id
  route_table_id = aws_route_table.public_vpc_route_table.id
}

resource "aws_internet_gateway" "public_vpc_igw" {
  vpc_id = aws_vpc.vpc_public.id

  tags = {
    Name = "Vpc Public internet Gateway"
  }
}

resource "aws_route_table_association" "vpc_public_igw_rtb_association" {
  gateway_id      = aws_internet_gateway.public_vpc_igw.id
  route_table_id = aws_route_table.public_vpc_route_table.id
}
