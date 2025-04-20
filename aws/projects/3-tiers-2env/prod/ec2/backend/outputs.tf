output "private_key" {
  value     = tls_private_key.prod_be.private_key_pem
  sensitive = true
}

output "security_group" {
  value     = aws_security_group.prod_be.id
}

output "ec2_id" {
  value     = aws_instance.prod_be.id
}
