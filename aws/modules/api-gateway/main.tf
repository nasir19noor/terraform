resource "aws_api_gateway_rest_api" "this" {
  name = var.api_name

  endpoint_configuration {
    types = [var.endpoint_type]
  }

  tags = var.tags
}