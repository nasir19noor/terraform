variable "function_name" {
  description = "Name for the Lambda function."
  type        = string
}

variable "runtime" {
  description = "Runtime for the Lambda function."
  type        = string
}

variable "architecture" {
  description = "Instruction set architecture for the function."
  type        = string
}

variable "role_name" {
  description = "Name for the IAM role."
  type        = string
}

variable "source_code_path" {
  description = "The file path for the Lambda function's source code."
  type        = string
}

variable "tags" {
  description = "A map of tags to assign to the resources."
  type        = map(string)
  default     = {}
}