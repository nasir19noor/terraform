resource "aws_eip" "dev_web" {
  vpc = true
  instance = aws_instance.dev_web.id
}
