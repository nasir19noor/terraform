output "private_key" {
  value     = tls_private_key.prod_web.private_key_pem
  sensitive = true
}

output "security_group" {
  value     = aws_security_group.prod_web.id
}

output "ec2_id" {
  value     = aws_instance.prod_web.id
}
