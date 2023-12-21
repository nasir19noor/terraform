resource "aws_internet_gateway" "dev" {
 vpc_id = aws_vpc.dev.id
 
 tags = {
   Name = "${var.project}-dev-igw"
 }
}

resource "aws_internet_gateway" "prod" {
 vpc_id = aws_vpc.prod.id
 
 tags = {
   Name = "${var.project}-prod-igw"
 }
}