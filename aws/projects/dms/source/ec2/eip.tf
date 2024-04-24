resource "aws_eip" "ec2-source" {
  vpc = true
  instance = aws_instance.source.id

  tags = {
    Name = "${var.project}-${var.env}"
  }  
}
