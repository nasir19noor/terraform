resource "aws_instance" "dev_web" {
  ami           = var.ami-amazon[0]
  instance_type = var.instance_type[0]
  subnet_id     = data.terraform_remote_state.vpc.outputs.dev_public_subnets[0]
  tags = {
   Name = "${var.project}-dev-web"
 }
}