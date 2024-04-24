resource "aws_eip" "ec2-target" {
  vpc = true
  instance = aws_instance.target.id

  tags = {
    Name = "${var.project}-${var.env}"
  }  
}
