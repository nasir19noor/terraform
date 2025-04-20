resource "aws_vpc" "vpc" {
 cidr_block = var.cidrs
 enable_dns_hostnames = true
 enable_dns_support = true
 tags = {
   Name = "${var.project}-${var.env}"
 }
}

