# Package the lambda function code into a zip archive.
data "archive_file" "lambda_zip" {
  type        = "zip"
  source_file = var.source_code_path # This now points to the path passed from the root module
  output_path = "${path.module}/lambda_function.zip"
}

# Create the Lambda Function resource
resource "aws_lambda_function" "this" {
  function_name = var.function_name
  role          = aws_iam_role.lambda_exec_role.arn
  handler       = "lambda_function.lambda_handler"
  runtime       = var.runtime
  architectures = [var.architecture]

  filename         = data.archive_file.lambda_zip.output_path
  source_code_hash = data.archive_file.lambda_zip.output_base64sha256

  tags = var.tags

  depends_on = [
    aws_iam_role.lambda_exec_role,
    aws_iam_role_policy_attachment.lambda_basic_execution
  ]
}
