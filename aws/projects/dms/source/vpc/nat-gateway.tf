resource "aws_nat_gateway" "ngw" {
  allocation_id = aws_eip.ngw.id
  count = 1
  subnet_id = aws_subnet.public_subnets[0].id
  tags = {
    "Name" = "${var.project}-${var.env}-ngw"
  }
}
