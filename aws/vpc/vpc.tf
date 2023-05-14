resource "aws_vpc" "nasir-vpc" {
    cidr_block = "10.0.0.0/16"
    enable_dns_support = "true"
    enable_dns_hostnames = "true" 
    instance_tenancy = "default" 
    
    tags =  {
        Name = "nasir-vpc"
    }
}

resource "aws_subnet" "nasir-subnet-public-1" {
    vpc_id = "${aws_vpc.nasir-vpc.id}"
    cidr_block = "10.0.1.0/24"
    map_public_ip_on_launch = "true"
    availability_zone = "ap-southeast-1a"
    tags = {
        Name = "nasir-subnet-public-1"
    }
}

resource "aws_subnet" "nasir-subnet-public-2" {
    vpc_id = "${aws_vpc.nasir-vpc.id}"
    cidr_block = "10.0.2.0/24"
    map_public_ip_on_launch = "true"
    availability_zone = "ap-southeast-1b"
    tags = {
        Name = "nasir-subnet-public-2"
    }
}