provider "aws" {
  region = "ap-southeast-1"
}

resource "aws_instance" "example" {
  ami = "ami-052f483c20fa1351a"  
  instance_type = "t2.micro"  

  tags = {
    Name = "my-ec2-instance"
  }
}