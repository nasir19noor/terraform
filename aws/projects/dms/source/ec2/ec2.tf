
resource "tls_private_key" "source" {
  algorithm = "RSA"
  rsa_bits = 4096
}

resource "aws_key_pair" "source" {
  key_name = var.key_name
  public_key = tls_private_key.source.public_key_openssh
}

resource "aws_instance" "source" {
  ami           = var.ami-ubuntu[1]
  instance_type = var.instance_type[0]
  subnet_id     = data.terraform_remote_state.vpc.outputs.public_subnets[1]
  key_name = aws_key_pair.source.key_name
  vpc_security_group_ids = [aws_security_group.source.id]
  associate_public_ip_address = true
  user_data = file("userdata.tpl")
  tags = {
   Name = "${var.project}-${var.env}"
 }
}

