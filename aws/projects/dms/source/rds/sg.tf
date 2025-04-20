resource "aws_security_group" "postgresql" {
  name                   = "${var.project}-${var.env}-postgresql"
  description            = "${var.project}-${var.env}-postgresql"
  vpc_id                 = data.terraform_remote_state.vpc.outputs.vpc_id

  tags = {
    Name = "${var.project}-${var.env}-postgresql"
  }
}

resource "aws_security_group_rule" "postgresql" {
  security_group_id = aws_security_group.postgresql.id
  type              = "ingress"

  cidr_blocks      = ["10.0.0.0/8"]
  description      = "postgresql"

  from_port = 5432
  to_port   = 5432
  protocol  = "tcp"
}


resource "aws_security_group_rule" "outbond" {
  security_group_id = aws_security_group.postgresql.id
  type              = "egress"

  cidr_blocks      = ["0.0.0.0/0"]
  ipv6_cidr_blocks = ["::/0"]
  description      = "egress"

  from_port = 0
  to_port   = 0
  protocol  = "-1"
}
