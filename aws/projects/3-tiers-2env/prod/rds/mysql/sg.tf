resource "aws_security_group" "prod_mysql" {
  name                   = "${var.project}-prod_mysql"
  description            = "prod_mysql-SG"
  vpc_id                 = data.terraform_remote_state.vpc.outputs.vpc_id

  tags = {
    Name = "${var.project}-prod_mysql"
  }
}

resource "aws_security_group_rule" "mysql" {
  security_group_id = aws_security_group.prod_mysql.id
  type              = "ingress"

  cidr_blocks      = ["10.1.0.0/16"]
  description      = "mysql"

  from_port = 3306
  to_port   = 3306
  protocol  = "tcp"
}


resource "aws_security_group_rule" "outbond" {
  security_group_id = aws_security_group.prod_mysql.id
  type              = "egress"

  cidr_blocks      = ["0.0.0.0/0"]
  ipv6_cidr_blocks = ["::/0"]
  description      = "egress"

  from_port = 0
  to_port   = 0
  protocol  = "-1"
}
