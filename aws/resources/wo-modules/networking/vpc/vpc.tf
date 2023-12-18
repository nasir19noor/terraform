resource "aws_vpc" "dev" {
 cidr_block = var.dev_cidrs
 enable_dns_hostnames = true
 enable_dns_support = true
 tags = {
   Name = "${var.project}-dev"
 }
}

resource "aws_vpc" "prod" {
 cidr_block = var.prod_cidrs
 enable_dns_hostnames = true
 enable_dns_support = true
 tags = {
   Name = "${var.project}-prod"
 }
}