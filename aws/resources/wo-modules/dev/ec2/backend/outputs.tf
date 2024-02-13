output "private_key" {
  value     = tls_private_key.dev_be.private_key_pem
  sensitive = true
}

output "security_group" {
  value     = aws_security_group.dev_be.id
}

output "ec2_id" {
  value     = aws_instance.dev_be.id
}
