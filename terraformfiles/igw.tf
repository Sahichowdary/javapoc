
resource "aws_internet_gateway" "public_vpc_igw" {
  vpc_id = aws_vpc.vpc_public.id

  tags = {
    Name = "Vpc Public internet Gateway"
  }
}

