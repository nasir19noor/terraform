output "endpoint" {
  value       = aws_db_instance.mysql.endpoint
}

output "db_connect_string" {
  description = "MySQL database connection string"
  value       = "Server=${aws_db_instance.mysql.address}; Database=ExampleDB; Uid=${var.username}; Pwd=${var.password}"
  sensitive   = true
}