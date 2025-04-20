output "arn" {
  description = "The ARN of the load balancer"
  value       = aws_lb.this.arn
}

output "arn_suffix" {
  description = "The ARN suffix for use with CloudWatch Metrics"
  value       = aws_lb.this.arn_suffix
}

output "dns_name" {
  description = "The DNS name of the load balancer"
  value       = aws_lb.this.dns_name
}

output "id" {
  description = "The ARN of the load balancer"
  value       = aws_lb.this.id
}

output "outposts_id" {
  description = "ID of the Outpost containing the load balancer"
  value       = aws_lb.this.subnet_mapping.*.outpost_id
}

output "tags_all" {
  description = "A map of tags assigned to the resource"
  value       = aws_lb.this.tags_all
}

output "zone_id" {
  description = "A map of tags assigned to the resource"
  value       = aws_lb.this.zone_id
}