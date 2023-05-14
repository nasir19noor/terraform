resource "aws_instance" "nasir" {
    ami           = "ami-052f483c20fa1351a" # us-west-2
    instance_type = "t2.micro"
    subnet_id = "subnet-05bfad7fa74873805"
    availability_zone = "ap-southeast-1a"
    key_name = "nasir"
    tags = {
        Name = "nasir"
    }
}

resource "aws_ec2_instance_state" "nasir" {
  instance_id = aws_instance.nasir.id
  state       = "stopped"
}