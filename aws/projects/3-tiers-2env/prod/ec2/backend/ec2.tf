
resource "tls_private_key" "prod_be" {
  algorithm = "RSA"
  rsa_bits = 4096
}

resource "aws_key_pair" "prod_be" {
  key_name = var.key_name
  public_key = tls_private_key.prod_be.public_key_openssh
}

resource "aws_instance" "prod_be" {
  ami           = var.ami-ubuntu[0]
  instance_type = var.instance_type[0]
  subnet_id     = data.terraform_remote_state.vpc.outputs.private_subnets[1]
  key_name = aws_key_pair.prod_be.key_name
  vpc_security_group_ids = [aws_security_group.prod_be.id]
  user_data = file("userdata.tpl")
  tags = {
   Name = "${var.project}-prod-be"
 }
}

