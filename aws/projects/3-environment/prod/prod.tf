provider "aws" {
  profile = "default"
  region  = "ap-southeast-1"
}

resource "aws_vpc" "nri_prod_vpc" {
  cidr_block = "10.3.0.0/16"

  tags = {
    Name = "nri_prod_vpc"
  }
}

resource "aws_subnet" "nri_prod_public_subnet" {
  vpc_id            = aws_vpc.nri_prod_vpc.id
  cidr_block        = "10.3.1.0/24"
  availability_zone = "ap-southeast-1a"

  tags = {
    Name = "nri_prod_public_subnet"
  }
}

resource "aws_subnet" "nri_prod_private_subnet" {
  vpc_id            = aws_vpc.nri_prod_vpc.id
  cidr_block        = "10.3.11.0/24"
  availability_zone = "ap-southeast-1b"

  tags = {
    Name = "nri_prod_private_subnet"
  }
}

resource "aws_internet_gateway" "nri_prod_ig" {
  vpc_id = aws_vpc.nri_prod_vpc.id

  tags = {
    Name = "nri_prod_ig"
  }
}

resource "aws_route_table" "nri_prod_public_rt" {
  vpc_id = aws_vpc.nri_prod_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.nri_prod_ig.id
  }

  route {
    ipv6_cidr_block = "::/0"
    gateway_id      = aws_internet_gateway.nri_prod_ig.id
  }

  tags = {
    Name = "nri_prod_public_rt"
  }
}

resource "aws_route_table" "nri_prod_private_rt" {
  vpc_id = aws_vpc.nri_prod_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    network_interface_id = aws_instance.nri_prod_nat_instance.primary_network_interface_id
  }

  route {
    ipv6_cidr_block = "::/0"
    network_interface_id = aws_instance.nri_prod_nat_instance.primary_network_interface_id
  }

  tags = {
    Name = "nri_prod_private_rt"
  }
}

resource "aws_route_table_association" "public_1_rt_a" {
  subnet_id      = aws_subnet.nri_prod_public_subnet.id
  route_table_id = aws_route_table.nri_prod_public_rt.id
}

resource "aws_route_table_association" "private_1_rt_a" {
  subnet_id      = aws_subnet.nri_prod_private_subnet.id
  route_table_id = aws_route_table.nri_prod_private_rt.id
}

resource "aws_security_group" "nri_prod_web_sg" {
  name   = "nri_prod_web_sg"
  vpc_id = aws_vpc.nri_prod_vpc.id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = -1
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    "Name" : "nri_prod_web_sg"
  }
}

resource "aws_security_group" "nri_prod_nat_sg" {
  name   = "nri_prod_nat_sg"
  vpc_id = aws_vpc.nri_prod_vpc.id
   
  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = -1
    cidr_blocks = ["10.1.0.0/16"]
  }
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = -1
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    "Name" : "nri_prod_nat_sg"
  }
}

resource "aws_instance" "nri_prod_web_instance" {
  ami           = "ami-012eebfcf9af751bd"
  instance_type = "t2.nano"
  key_name      = "nri_prod"

  subnet_id                   = aws_subnet.nri_prod_public_subnet.id
  vpc_security_group_ids      = [aws_security_group.nri_prod_web_sg.id]
  associate_public_ip_address = true

  user_data = <<-EOF
  #!/bin/bash -ex

  amazon-linux-extras install nginx1 -y
  echo "<h1>$(curl https://api.kanye.rest/?format=text)</h1>" >  /usr/share/nginx/html/index.html 
  systemctl enable nginx
  systemctl start nginx
  EOF

  tags = {
    "Name" : "nri_prod_web_instance"
  }
}

resource "aws_instance" "nri_prod_nat_instance" {
  ami           = "ami-012eebfcf9af751bd"
  instance_type = "t2.nano"
  key_name      = "nri_prod"

  subnet_id                   = aws_subnet.nri_prod_public_subnet.id
  vpc_security_group_ids      = [aws_security_group.nri_prod_nat_sg.id]
  associate_public_ip_address = true
  source_dest_check = false

  tags = {
    "Name" : "nri_prod_nat_instance"
  }
}

resource "aws_eip" "nri_prod_web" {
  domain = "vpc"
  tags = {
    "Name" : "nri_prod_web"
  }
}

resource "aws_eip" "nri_prod_nat" {
  domain = "vpc"
  tags = {
    "Name" : "nri_prod_nat"
  }
}

resource "aws_eip_association" "nri_prod_web" {
  instance_id   = aws_instance.nri_prod_web_instance.id
  allocation_id = aws_eip.nri_prod_web.id
}

resource "aws_eip_association" "nri_prod_nat" {
  instance_id   = aws_instance.nri_prod_nat_instance.id
  allocation_id = aws_eip.nri_prod_nat.id
}

