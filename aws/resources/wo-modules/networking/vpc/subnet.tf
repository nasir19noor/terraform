resource "aws_subnet" "dev_public_subnets" {
 count      = length(var.dev_public_subnet_cidrs)
 vpc_id     = aws_vpc.dev.id
 cidr_block = element(var.dev_public_subnet_cidrs, count.index)
 
 tags = {
   Name = "Dev Public Subnet ${count.index + 1}"
 }
}
 
resource "aws_subnet" "dev_private_subnets" {
 count      = length(var.dev_private_subnet_cidrs)
 vpc_id     = aws_vpc.dev.id
 cidr_block = element(var.dev_private_subnet_cidrs, count.index)
 
 tags = {
   Name = "Dev Private Subnet ${count.index + 1}"
 }
}

resource "aws_subnet" "prod_public_subnets" {
 count      = length(var.prod_public_subnet_cidrs)
 vpc_id     = aws_vpc.prod.id
 cidr_block = element(var.prod_public_subnet_cidrs, count.index)
 
 tags = {
   Name = "Public Subnet ${count.index + 1}"
 }
}

resource "aws_subnet" "prod_private_subnets" {
 count      = length(var.prod_private_subnet_cidrs)
 vpc_id     = aws_vpc.prod.id
 cidr_block = element(var.prod_private_subnet_cidrs, count.index)
 
 tags = {
   Name = "Dev Private Subnet ${count.index + 1}"
 }
}