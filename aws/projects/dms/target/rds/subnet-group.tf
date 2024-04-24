resource "aws_db_subnet_group" "postgresql" {
  name       = "target"
  subnet_ids = [data.terraform_remote_state.vpc.outputs.private_subnets[0], data.terraform_remote_state.vpc.outputs.private_subnets[1], data.terraform_remote_state.vpc.outputs.private_subnets[2] ]

  tags = {
    Name = "${var.project}-${var.env}"
  }
}