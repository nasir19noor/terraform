output "function_name" {
  description = "The name of the Lambda function."
  value       = aws_lambda_function.this.function_name
}

output "function_arn" {
  description = "The ARN of the Lambda function."
  value       = aws_lambda_function.this.arn
}

output "role_arn" {
  description = "The ARN of the IAM role."
  value       = aws_iam_role.lambda_exec_role.arn
}