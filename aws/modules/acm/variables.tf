variable "provider" {
  description = "provider"
  type        = string
}
variable "domain_name" {
  description = "domain name"
  type        = string
}

variable "validation_method" {
  description = "validation method"
  type        = string
  default     = "DNS"
}

variable "wait_for_validation" {
  description = "Wait for validation"
  type        = bool
  default     = false
}

variable "create_before_destroy" {
  description = "Create before destroy"
  type        = bool
  default     = true
}
