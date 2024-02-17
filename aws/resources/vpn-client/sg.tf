resource "aws_security_group" "client_vpn_sg" {
  name   = "rpp-client-vpn-sg"
  vpc_id = data.terraform_remote_state.prod_networking_vpc.outputs.vpc_id
  description = "Allow inbound traffic from port 443, to the VPN"
 
  ingress {
   protocol         = "tcp"
   from_port        = 443
   to_port          = 443
   cidr_blocks      = ["0.0.0.0/0"]
   ipv6_cidr_blocks = ["::/0"]
  }
 
  egress {
   protocol         = "-1"
   from_port        = 0
   to_port          = 0
   cidr_blocks      = ["0.0.0.0/0"]
   ipv6_cidr_blocks = ["::/0"]
  }
  tags = merge(
    { Name = "rpp-client-vpn-sg" },
    module.required_tags.tags
  )
}