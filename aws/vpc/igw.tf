resource "aws_internet_gateway" "nasir-igw" {
    vpc_id = "${aws_vpc.nasir-vpc.id}"
    tags = {
        Name = "nasir-igw"
    }
}