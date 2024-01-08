output "private_key" {
  value     = tls_private_key.dev_web.private_key_pem
  sensitive = true
}