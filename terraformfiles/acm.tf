resource "aws_acm_certificate" "poc_cert_app" {
  domain_name       = "saskenpoc.com"
  validation_method = "DNS"

  tags = {
    Environment = "test"
  }

  lifecycle {
    create_before_destroy = true
  }
}
