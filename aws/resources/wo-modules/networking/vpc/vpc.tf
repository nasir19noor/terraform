resource "aws_vpc" "dev" {
 cidr_block = "10.1.0.0/16"
 
 tags = {
   Name = "Nasir Terraform VPC Dev"
 }
}

resource "aws_vpc" "prod" {
 cidr_block = "10.2.0.0/16"
 
 tags = {
   Name = "Nasir Terraform VPC Prod"
 }
}