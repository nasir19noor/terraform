output "arn_suffix" {
  description = "The ARN suffix for use with CloudWatch Metrics"
  value       = aws_lb_target_group.this.arn_suffix
}

output "arn" {
  description = "The ARN of the Target Group"
  value       = aws_lb_target_group.this.arn
}

output "name" {
  description = "The name of the Target Group"
  value       = aws_lb_target_group.this.name
}

output "tags_all" {
  description = "A map of tags assigned to the resource"
  value       = aws_lb_target_group.this.tags_all
}

output "id" {
  description = "A unique identifier for the attachment"
  value       = aws_lb_target_group_attachment.this.id
}