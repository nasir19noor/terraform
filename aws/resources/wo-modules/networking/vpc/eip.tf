resource "aws_eip" "dev_ngw" {
  vpc = true
}

resource "aws_eip" "prod_ngw" {
  vpc = true
}