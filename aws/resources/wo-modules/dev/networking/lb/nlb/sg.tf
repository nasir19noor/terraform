resource "aws_security_group" "dev_be_lb" {
  name                   = "${var.project}-dev_be_lb"
  description            = "dev_be-SG"
  vpc_id                 = data.terraform_remote_state.vpc.outputs.vpc_id

  tags = {
    Name = "${var.project}-dev_be_lb"
  }
}

resource "aws_security_group_rule" "http" {
  security_group_id = aws_security_group.dev_be_lb.id
  type              = "ingress"

  cidr_blocks      = ["10.1.0.0/16"]
  ipv6_cidr_blocks = ["::/0"]
  description      = "http"

  from_port = 80
  to_port   = 80
  protocol  = "tcp"
}

resource "aws_security_group_rule" "https" {
  security_group_id = aws_security_group.dev_be_lb.id
  type              = "ingress"

  cidr_blocks      = ["10.1.0.0/16"]
  ipv6_cidr_blocks = ["::/0"]
  description      = "https"

  from_port = 443
  to_port   = 443
  protocol  = "tcp"
}

resource "aws_security_group_rule" "outbond" {
  security_group_id = aws_security_group.dev_be_lb.id
  type              = "egress"

  cidr_blocks      = ["0.0.0.0/0"]
  ipv6_cidr_blocks = ["::/0"]
  description      = "egress"

  from_port = 0
  to_port   = 0
  protocol  = "-1"
}
