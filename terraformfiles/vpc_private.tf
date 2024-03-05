resource "aws_vpc" "vpc_private" {
  cidr_block       = "172.34.0.0/16"
  enable_dns_support = true
  enable_dns_hostnames = true

   tags = {
    Name = "Private VPC"
  }
}

resource "aws_subnet" "vpc_private_subnet_private_1" {
  vpc_id     = aws_vpc.vpc_private.id
  cidr_block = "172.34.0.0/20"
  availability_zone = var.availability_zone

  tags = {
    Name = "pocdemo-subnet-private1-us-west-2a"
  }
}

resource "aws_route_table" "private_vpc_route_table" {
  vpc_id = aws_vpc.vpc_private.id

  tags = {
    Name = "Private Route table"
  }
}

resource "aws_route_table_association" "vpc_private_subnet_private_1_rtb_association" {
  subnet_id      = aws_subnet.vpc_private_subnet_private_1.id
  route_table_id = aws_route_table.private_vpc_route_table.id
}




resource "aws_subnet" "vpc_private_subnet_private_2" {
  vpc_id     = aws_vpc.vpc_private.id
  cidr_block = "172.34.16.0/20"
  availability_zone = var.availability_zone2

  tags = {
    Name = "pocdemo-subnet-private2-us-west-2a"
  }
}

resource "aws_route_table_association" "vpc_private_subnet_private_2_rtb_association" {
  subnet_id      = aws_subnet.vpc_private_subnet_private_2.id
  route_table_id = aws_route_table.private_vpc_route_table.id
}





resource "aws_subnet" "vpc_private_subnet_private_3" {
  vpc_id     = aws_vpc.vpc_private.id
  cidr_block = "172.34.32.0/20"
  availability_zone = var.availability_zone

  tags = {
    Name = "pocdemo-subnet-private3-us-west-2a"
  }
}

resource "aws_route_table_association" "vpc_private_subnet_private_3_rtb_association" {
  subnet_id      = aws_subnet.vpc_private_subnet_private_3.id
  route_table_id = aws_route_table.private_vpc_route_table.id
}




resource "aws_subnet" "vpc_private_subnet_private_4" {
  vpc_id     = aws_vpc.vpc_private.id
  cidr_block = "172.34.48.0/20"
  availability_zone = var.availability_zone2

  tags = {
    Name = "pocdemo-subnet-private4-us-west-2a"
  }
}

resource "aws_route_table_association" "vpc_private_subnet_private_4_rtb_association" {
  subnet_id      = aws_subnet.vpc_private_subnet_private_4.id
  route_table_id = aws_route_table.private_vpc_route_table.id
}





resource "aws_subnet" "vpc_private_subnet_private_5" {
  vpc_id     = aws_vpc.vpc_private.id
  cidr_block = "172.34.64.0/20"
  availability_zone = var.availability_zone

  tags = {
    Name = "pocdemo-subnet-private3-us-west-2a"
  }
}

resource "aws_route_table_association" "vpc_private_subnet_private_5_rtb_association" {
  subnet_id      = aws_subnet.vpc_private_subnet_private_5.id
  route_table_id = aws_route_table.private_vpc_route_table.id
}





resource "aws_subnet" "vpc_private_subnet_private_6" {
  vpc_id     = aws_vpc.vpc_private.id
  cidr_block = "172.34.80.0/20"
  availability_zone = var.availability_zone

  tags = {
    Name = "pocdemo-subnet-private3-us-west-2a"
  }
}

resource "aws_route_table_association" "vpc_private_subnet_private_6_rtb_association" {
  subnet_id      = aws_subnet.vpc_private_subnet_private_6.id
  route_table_id = aws_route_table.private_vpc_route_table.id
}
