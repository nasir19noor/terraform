variable "domain_name" {
  description = "domain name"
  type        = string
}

variable "validation_method" {
  description = "validation method"
  type        = string
  default     = "DNS"
}