resource "aws_eip" "prod_web" {
  vpc = true
  instance = aws_instance.prod_web.id
}
