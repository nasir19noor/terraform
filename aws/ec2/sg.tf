resource "aws_security_group" "public-sg" {
    vpc_id = "vpc-0fe724702c32fd85f"
    
    egress {
        from_port = 0
        to_port = 0
        protocol = -1
        cidr_blocks = ["0.0.0.0/0"]
    }
    ingress {
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
        description = "SSH from all"
    }
    ingress {
        from_port = 80
        to_port = 80
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
        description = "http from all"
    }
    tags = {
        Name = "public-sg"
    }
    name = "public-sg"
}