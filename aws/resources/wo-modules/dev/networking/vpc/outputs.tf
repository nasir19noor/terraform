output "vpc_id" {
  description = "The ID of the VPC"
  value       = try(aws_vpc.vpc.id, null)
}


output "public_subnets" {
  description = "The ID of the Public Subnet"
  value       = aws_subnet.public_subnets[*].id
}

output "private_subnets" {
  description = "The ID of the Private Subnet"
  value       = aws_subnet.private_subnets[*].id
}

output "eip_ngw" {
  description = "The ID of the VPC"
  value       = try(aws_eip.ngw.public_ip, null)
}

