
resource "tls_private_key" "target" {
  algorithm = "RSA"
  rsa_bits = 4096
}

resource "aws_key_pair" "target" {
  key_name = var.key_name
  public_key = tls_private_key.target.public_key_openssh
}

resource "aws_instance" "target" {
  ami           = "ami-02d9cb9327234d514"
  instance_type = var.instance_type[0]
  subnet_id     = data.terraform_remote_state.vpc.outputs.public_subnets[1]
  key_name = aws_key_pair.target.key_name
  vpc_security_group_ids = [aws_security_group.target.id]
  associate_public_ip_address = true
  user_data = file("userdata.tpl")
  tags = {
   Name = "${var.project}-${var.env}"
 }
}

