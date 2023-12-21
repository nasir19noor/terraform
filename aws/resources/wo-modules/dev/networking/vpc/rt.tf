resource "aws_route_table" "dev_public" {
 vpc_id = aws_vpc.dev.id
 
 route {
   cidr_block = "0.0.0.0/0"
   gateway_id = aws_internet_gateway.dev.id
 }
 
 tags = {
   Name = "${var.project}-dev_public_rt"
 }
}

resource "aws_route_table" "dev_private" {
 vpc_id = aws_vpc.dev.id
 
 route {
   cidr_block = "0.0.0.0/0"
   nat_gateway_id = aws_nat_gateway.dev[0].id
 }
 
 tags = {
   Name = "${var.project}-dev_private_rt"
 }
}

resource "aws_route_table" "prod_public" {
 vpc_id = aws_vpc.prod.id
 
 route {
   cidr_block = "0.0.0.0/0"
   gateway_id = aws_internet_gateway.prod.id
 }
 
 tags = {
   Name = "${var.project}-prod_public_rt"
 }
}

resource "aws_route_table" "prod_private" {
 vpc_id = aws_vpc.prod.id
 
 route {
   cidr_block = "0.0.0.0/0"
   nat_gateway_id = aws_nat_gateway.prod[0].id
 }
 
 tags = {
   Name = "${var.project}-prod_private_rt"
 }
}

resource "aws_route_table_association" "dev_public_subnet_asso" {
 count = length(var.dev_public_subnet_cidrs)
 subnet_id      = element(aws_subnet.dev_public_subnets[*].id, count.index)
 route_table_id = aws_route_table.dev_public.id
}

resource "aws_route_table_association" "dev_private_subnet_asso" {
 count = length(var.dev_private_subnet_cidrs)
 subnet_id      = element(aws_subnet.dev_private_subnets[*].id, count.index)
 route_table_id = aws_route_table.dev_private.id
}

resource "aws_route_table_association" "prod_public_subnet_asso" {
 count = length(var.prod_public_subnet_cidrs)
 subnet_id      = element(aws_subnet.prod_public_subnets[*].id, count.index)
 route_table_id = aws_route_table.prod_public.id
}

resource "aws_route_table_association" "prod_private_subnet_asso" {
 count = length(var.prod_private_subnet_cidrs)
 subnet_id      = element(aws_subnet.prod_private_subnets[*].id, count.index)
 route_table_id = aws_route_table.prod_private.id
}