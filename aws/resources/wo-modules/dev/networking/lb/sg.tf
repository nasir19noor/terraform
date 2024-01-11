resource "aws_security_group" "dev_web_lb" {
  name                   = "${var.project}-dev_web-lb"
  description            = "dev_web-SG"
  vpc_id                 = data.terraform_remote_state.vpc.outputs.vpc_id

  tags = {
    Name = "${var.project}-dev_web-lb"
  }
}

resource "aws_security_group_rule" "http" {
  security_group_id = aws_security_group.dev_web.id
  type              = "ingress"

  cidr_blocks      = ["0.0.0.0/0"]
  ipv6_cidr_blocks = ["::/0"]
  description      = "http"

  from_port = 80
  to_port   = 80
  protocol  = "tcp"
}

resource "aws_security_group_rule" "https" {
  security_group_id = aws_security_group.dev_web.id
  type              = "ingress"

  cidr_blocks      = ["0.0.0.0/0", "52.220.17.199/32"]
  ipv6_cidr_blocks = ["::/0"]
  description      = "https"

  from_port = 443
  to_port   = 443
  protocol  = "tcp"
}

resource "aws_security_group_rule" "outbond" {
  security_group_id = aws_security_group.dev_web.id
  type              = "egress"

  cidr_blocks      = ["0.0.0.0/0"]
  ipv6_cidr_blocks = ["::/0"]
  description      = "egress"

  from_port = 0
  to_port   = 0
  protocol  = "-1"
}
