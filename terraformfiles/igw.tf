
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
