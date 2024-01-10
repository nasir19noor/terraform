
resource "tls_private_key" "dev_web" {
  algorithm = "RSA"
  rsa_bits = 4096
}

resource "aws_key_pair" "dev_web" {
  key_name = var.key_name
  public_key = tls_private_key.dev_web.public_key_openssh
}

resource "aws_instance" "dev_web" {
  ami           = var.ami-ubuntu[0]
  instance_type = var.instance_type[0]
  subnet_id     = data.terraform_remote_state.vpc.outputs.public_subnets[1]
  key_name = aws_key_pair.dev_web.key_name
  vpc_security_group_ids = [aws_security_group.dev_web.id]
  user_data = file("userdata.tpl")
  tags = {
   Name = "${var.project}-dev-web"
 }
}

