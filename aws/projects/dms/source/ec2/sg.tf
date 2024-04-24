resource "aws_security_group" "source" {
  name                   = "${var.project}-${var.env}"
  description            = "source-SG"
  vpc_id                 = data.terraform_remote_state.vpc.outputs.vpc_id

  tags = {
    Name = "${var.project}-${var.env}"
  }
}

resource "aws_security_group_rule" "http" {
  security_group_id = aws_security_group.source.id
  type              = "ingress"

  cidr_blocks      = ["0.0.0.0/0"]
  description      = "http"

  from_port = 80
  to_port   = 80
  protocol  = "tcp"
}

resource "aws_security_group_rule" "https" {
  security_group_id = aws_security_group.source.id
  type              = "ingress"

  cidr_blocks      = ["0.0.0.0/0"]
  description      = "https"

  from_port = 443
  to_port   = 443
  protocol  = "tcp"
}

resource "aws_security_group_rule" "ssh" {
  security_group_id = aws_security_group.source.id
  type              = "ingress"

  cidr_blocks      = ["0.0.0.0/0"]
  description      = "ssh"

  from_port = 22
  to_port   = 22
  protocol  = "tcp"
}
resource "aws_security_group_rule" "outbond" {
  security_group_id = aws_security_group.source.id
  type              = "egress"

  cidr_blocks      = ["0.0.0.0/0"]
  ipv6_cidr_blocks = ["::/0"]
  description      = "egress"

  from_port = 0
  to_port   = 0
  protocol  = "-1"
}
