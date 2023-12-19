output "dev_vpc_id" {
  description = "The ID of the Dev VPC"
  value       = try(aws_vpc.dev.id, null)
}

output "prod_vpc_id" {
  description = "The ID of the Dev VPC"
  value       = try(aws_vpc.prod.id, null)
}

output "dev_public_subnets" {
  description = "The ID of the Public Subnet 1"
  value       = aws_subnet.dev_public_subnets[*].id
}

output "dev_private_subnets" {
  description = "The ID of the Private Subnet 1"
  value       = aws_subnet.dev_private_subnets[*].id
}

output "prod_public_subnets" {
  description = "The ID of the Public Subnet 1"
  value       = aws_subnet.prod_public_subnets[*].id
}

output "prod_private_subnets" {
  description = "The ID of the Private Subnet 1"
  value       = aws_subnet.prod_private_subnets[*].id
}

