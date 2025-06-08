resource "aws_acm_certificate" "this" {
  domain_name       = var.domain_name
  validation_method = var.validation_method

  lifecycle {
    create_before_destroy = true
  }

  tags = {
    Name = var.domain_name
  }
}