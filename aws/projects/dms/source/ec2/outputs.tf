output "private_key" {
  value     = tls_private_key.source.private_key_pem
  sensitive = true
}

output "security_group" {
  value     = aws_security_group.source.id
}

output "ec2_id" {
  value     = aws_instance.source.id
}
