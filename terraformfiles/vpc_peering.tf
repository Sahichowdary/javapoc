
resource "aws_vpc_peering_connection" "private_to_public" {
    peer_vpc_id = aws_vpc.vpc_public.id
    vpc_id = aws_vpc.vpc_private.id
}
