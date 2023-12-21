resource "aws_nat_gateway" "dev" {
  allocation_id = aws_eip.dev_ngw.id
  count = 1
  subnet_id = aws_subnet.dev_public_subnets[0].id
  tags = {
    "Name" = "${var.project}-dev-ngw"
  }
}

resource "aws_nat_gateway" "prod" {
  allocation_id = aws_eip.prod_ngw.id
  count = 1
  subnet_id = aws_subnet.prod_public_subnets[0].id
  tags = {
    "Name" = "${var.project}-prod-ngw"
  }
}