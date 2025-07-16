output "api_name" {
  description = "The name of the API Gateway."
  value       = aws_api_gateway_rest_api.this.name
}

output "api_id" {
  description = "The ID of the API Gateway."
  value       = aws_api_gateway_rest_api.this.id
}

output "api_execution_arn" {
  description = "The execution ARN of the API Gateway."
  value       = aws_api_gateway_rest_api.this.execution_arn
}