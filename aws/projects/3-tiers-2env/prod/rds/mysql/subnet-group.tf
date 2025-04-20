resource "aws_db_subnet_group" "prod_mysql" {
  name       = "main"
  subnet_ids = [data.terraform_remote_state.vpc.outputs.data_subnets[0], data.terraform_remote_state.vpc.outputs.data_subnets[1], data.terraform_remote_state.vpc.outputs.data_subnets[2] ]

  tags = {
    Name = "prod_mysql_subnet_group"
  }
}