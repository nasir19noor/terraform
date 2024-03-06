output "arn" {
  description = "ARN of the listener (matches id)"
  value       = aws_lb_listener.this.arn
}

output "id" {
  description = "ARN of the listener (matches arn)"
  value       = aws_lb_listener.this.id
}

output "tags_all" {
  description = "A map of tags assigned to the resource"
  value       = aws_lb_listener.this.tags_all
}