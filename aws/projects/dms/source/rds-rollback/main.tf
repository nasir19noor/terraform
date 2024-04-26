resource "aws_db_instance" "postgresql" {
  engine               = var.engine[0]
  identifier           = var.identifier
  allocated_storage    = var.storage
  engine_version       = var.engine_version[0]
  instance_class       = var.instance_type[0]
  username             = var.username
  password             = var.password
  db_subnet_group_name  = aws_db_subnet_group.postgresql.id
  parameter_group_name = var.parameter_group_name
  vpc_security_group_ids = ["${aws_security_group.postgresql.id}"]
  skip_final_snapshot  = true
  publicly_accessible =  false
}