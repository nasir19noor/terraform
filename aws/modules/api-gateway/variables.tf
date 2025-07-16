variable "api_name" {
  description = "The name for the API Gateway REST API."
  type        = string
}

variable "endpoint_type" {
  description = "The endpoint type for the API. Valid values are REGIONAL, EDGE, PRIVATE."
  type        = string
  default     = "REGIONAL"
}

variable "tags" {
  description = "A map of tags to assign to the resources."
  type        = map(string)
  default     = {}
}