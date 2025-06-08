resource "aws_acm_certificate" "this" {
  domain_name          = var.domain_name
  validation_method    = var.validation_method
  wait_for_validation  = var.wait_for_validation
  lifecycle {
    create_before_destroy = var.create_before_destroy
  }

  tags = {
    Name = var.domain_name
  }
}