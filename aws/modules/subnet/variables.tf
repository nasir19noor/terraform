variable "vpc_id" {
  description = "The VPC ID where subnets will be created"
  type        = string
}

variable "region" {
  description = "AWS region to deploy to"
  type        = string
}

variable "cidr_blocks" {
  description = "List of CIDR blocks for the subnets"
  type        = list(string)
}

variable "subnet_count" {
  description = "Number of subnets to create"
  type        = number
}

variable "tags" {
  description = "Tags to apply to the subnets"
  type        = map(string)
  default     = {}
}