resource "aws_eip" "dev_be" {
  vpc = true
  instance = aws_instance.dev_web.id
}
