resource "aws_route53_zone" "poc_route53_zone" {
  name = "javaexpamplepoc.com"

  tags = {
    Environment = "test"
  }
}


resource "aws_route53_record" "route_poc" {
  zone_id = aws_route53_zone.poc_route53_zone.id
  name    = "poc-java.com"
  type    = "A"
  ttl     = 300
 # records = [xxxxxxxxxx]
}

