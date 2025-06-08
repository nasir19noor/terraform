# modules/cloudfront/outputs.tf

output "cloudfront_distribution_id" {
  description = "The CloudFront distribution ID"
  value       = aws_cloudfront_distribution.this.id
}

output "cloudfront_distribution_arn" {
  description = "The CloudFront distribution ARN"
  value       = aws_cloudfront_distribution.this.arn
}

output "cloudfront_distribution_domain_name" {
  description = "The CloudFront distribution domain name"
  value       = aws_cloudfront_distribution.this.domain_name
}

output "cloudfront_distribution_hosted_zone_id" {
  description = "The CloudFront distribution hosted zone ID"
  value       = aws_cloudfront_distribution.this.hosted_zone_id
}

output "cloudfront_distribution_status" {
  description = "The CloudFront distribution status"
  value       = aws_cloudfront_distribution.this.status
}

output "cloudfront_distribution_etag" {
  description = "The CloudFront distribution ETag"
  value       = aws_cloudfront_distribution.this.etag
}

output "origin_access_control_ids" {
  description = "Map of Origin Access Control IDs"
  value       = { for k, v in aws_cloudfront_origin_access_control.s3_oac : k => v.id }
}