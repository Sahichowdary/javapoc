resource "aws_vpc" "vpc_private" {
  cidr_block       = "172.34.0.0/16"
  enable_dns_support = true
  enable_dns_hostnames = true

   tags = {
    Name = "Private VPC"
  }
}

