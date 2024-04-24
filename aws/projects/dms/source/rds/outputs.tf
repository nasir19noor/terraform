output "endpoint" {
  value       = aws_db_instance.postgresql.endpoint
}

output "db_connect_string" {
  description = "Postgresql database connection string"
  value       = "Server=${aws_db_instance.postgresql.address}; Database=ExampleDB; Uid=${var.username}; Pwd=${var.password}"
  sensitive   = true
}