resource "aws_route_table" "public" {
 vpc_id = aws_vpc.vpc.id
 
 route {
   cidr_block = "0.0.0.0/0"
   gateway_id = aws_internet_gateway.igw.id
 }
 
 tags = {
   Name = "${var.project}_${var.env}_public_rt"
 }
}

resource "aws_route_table" "private" {
 vpc_id = aws_vpc.vpc.id
 
 route {
   cidr_block = "0.0.0.0/0"
   nat_gateway_id = aws_nat_gateway.ngw[0].id
 }
 
 tags = {
   Name = "${var.project}_${var.env}_private_rt"
 }
}

resource "aws_route_table_association" "public_subnet_asso" {
 count = length(var.public_subnet_cidrs)
 subnet_id      = element(aws_subnet.public_subnets[*].id, count.index)
 route_table_id = aws_route_table.public.id
}

resource "aws_route_table_association" "dev_private_subnet_asso" {
 count = length(var.private_subnet_cidrs)
 subnet_id      = element(aws_subnet.private_subnets[*].id, count.index)
 route_table_id = aws_route_table.private.id
}

