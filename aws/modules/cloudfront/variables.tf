# modules/cloudfront/variables.tf

variable "distribution_name" {
  description = "Name identifier for the CloudFront distribution"
  type        = string
}

# Domain and Certificate Configuration
variable "domain_name" {
  description = "Primary domain name for the CloudFront distribution (used for single domain setup)"
  type        = string
  default     = null
}

variable "aliases" {
  description = "List of domain aliases (alternative to domain_name for multiple domains)"
  type        = list(string)
  default     = []
}

variable "acm_certificate_arn" {
  description = "ARN of the ACM certificate to use (if not provided, will lookup by domain)"
  type        = string
  default     = null
}

variable "acm_certificate_domain" {
  description = "Domain to lookup ACM certificate (if different from domain_name)"
  type        = string
  default     = null
}

# Origins Configuration
variable "origins" {
  description = "List of origins for the CloudFront distribution"
  type = list(object({
    domain_name              = string
    origin_id                = string
    origin_type              = string # "s3", "custom", "alb", etc.
    origin_path              = optional(string, "")
    http_port                = optional(number, 80)
    https_port               = optional(number, 443)
    origin_protocol_policy   = optional(string, "https-only")
    origin_ssl_protocols     = optional(list(string), ["TLSv1.2"])
    origin_keepalive_timeout = optional(number, 5)
    origin_read_timeout      = optional(number, 30)
    custom_headers           = optional(map(string), {})
  }))
}

# Distribution Settings
variable "enabled" {
  description = "Whether the distribution is enabled"
  type        = bool
  default     = true
}

variable "ipv6_enabled" {
  description = "Whether IPv6 is enabled for the distribution"
  type        = bool
  default     = true
}

variable "comment" {
  description = "Comment for the distribution"
  type        = string
  default     = "CloudFront distribution managed by Terraform"
}

variable "default_root_object" {
  description = "Object returned when a user requests the root URL"
  type        = string
  default     = "index.html"
}

variable "price_class" {
  description = "Price class for the distribution"
  type        = string
  default     = "PriceClass_100"
  validation {
    condition = contains([
      "PriceClass_All",
      "PriceClass_200",
      "PriceClass_100"
    ], var.price_class)
    error_message = "Price class must be PriceClass_All, PriceClass_200, or PriceClass_100."
  }
}

variable "web_acl_id" {
  description = "Web ACL ID to associate with the distribution"
  type        = string
  default     = null
}

# Default Cache Behavior
variable "default_cache_behavior" {
  description = "Default cache behavior configuration"
  type = object({
    target_origin_id           = string
    allowed_methods            = optional(list(string), ["DELETE", "GET", "HEAD", "OPTIONS", "PATCH", "POST", "PUT"])
    cached_methods             = optional(list(string), ["GET", "HEAD"])
    compress                   = optional(bool, true)
    viewer_protocol_policy     = optional(string, "redirect-to-https")
    cache_policy_id            = optional(string, null)
    origin_request_policy_id   = optional(string, null)
    response_headers_policy_id = optional(string, null)
    realtime_log_config_arn    = optional(string, null)
    
    # Legacy forwarded values (used when cache_policy_id is null)
    forward_query_string       = optional(bool, false)
    query_string_cache_keys    = optional(list(string), [])
    forward_headers            = optional(list(string), [])
    forward_cookies            = optional(string, "none")
    cookies_whitelisted_names  = optional(list(string), [])
    
    min_ttl                    = optional(number, 0)
    default_ttl                = optional(number, 3600)
    max_ttl                    = optional(number, 86400)
    
    trusted_signers            = optional(list(string), [])
    trusted_key_groups         = optional(list(string), [])
    
    lambda_function_associations = optional(list(object({
      event_type   = string
      lambda_arn   = string
      include_body = optional(bool, false)
    })), [])
    
    function_associations = optional(list(object({
      event_type   = string
      function_arn = string
    })), [])
  })
}

# Ordered Cache Behaviors
variable "ordered_cache_behaviors" {
  description = "Ordered list of cache behaviors"
  type = list(object({
    path_pattern               = string
    target_origin_id           = string
    allowed_methods            = optional(list(string), ["GET", "HEAD"])
    cached_methods             = optional(list(string), ["GET", "HEAD"])
    compress                   = optional(bool, true)
    viewer_protocol_policy     = optional(string, "redirect-to-https")
    cache_policy_id            = optional(string, null)
    origin_request_policy_id   = optional(string, null)
    response_headers_policy_id = optional(string, null)
    realtime_log_config_arn    = optional(string, null)
    
    # Legacy forwarded values (used when cache_policy_id is null)
    forward_query_string       = optional(bool, false)
    query_string_cache_keys    = optional(list(string), [])
    forward_headers            = optional(list(string), [])
    forward_cookies            = optional(string, "none")
    cookies_whitelisted_names  = optional(list(string), [])
    
    min_ttl                    = optional(number, 0)
    default_ttl                = optional(number, 3600)
    max_ttl                    = optional(number, 86400)
    
    trusted_signers            = optional(list(string), [])
    trusted_key_groups         = optional(list(string), [])
    
    lambda_function_associations = optional(list(object({
      event_type   = string
      lambda_arn   = string
      include_body = optional(bool, false)
    })), [])
    
    function_associations = optional(list(object({
      event_type   = string
      function_arn = string
    })), [])
  }))
  default = []
}

# Geo Restrictions
variable "geo_restriction" {
  description = "Geo restriction configuration"
  type = object({
    restriction_type = optional(string, "none")
    locations        = optional(list(string), [])
  })
  default = {
    restriction_type = "none"
    locations        = []
  }
}

# SSL/TLS Configuration
variable "minimum_protocol_version" {
  description = "Minimum SSL/TLS protocol version"
  type        = string
  default     = "TLSv1.2_2021"
}

# Custom Error Responses
variable "custom_error_responses" {
  description = "Custom error responses"
  type = list(object({
    error_code            = number
    response_code         = optional(number, null)
    response_page_path    = optional(string, null)
    error_caching_min_ttl = optional(number, 300)
  }))
  default = []
}

# Logging Configuration
variable "logging_config" {
  description = "Logging configuration"
  type = object({
    bucket          = string
    prefix          = optional(string, "")
    include_cookies = optional(bool, false)
  })
  default = null
}

# General Configuration
variable "tags" {
  description = "A map of tags to assign to the resource"
  type        = map(string)
  default     = {}
}

variable "wait_for_deployment" {
  description = "Whether to wait for distribution deployment"
  type        = bool
  default     = true
}