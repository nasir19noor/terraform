variable "access_logs" {
  description = "(Optional) An Access Logs block"
  type = object({
    bucket  = string
    enabled = optional(bool)
    prefix  = optional(string)
  })
  default = null
}

# variable "connection_logs" {
#   description = "(Optional) A Connection Logs block"
#   type = object({
#     bucket  = string
#     enabled = optional(bool)
#     prefix  = optional(string)
#   })
#   default = null
# }

variable "customer_owned_ipv4_pool" {
  description = "(Optional) The ID of the customer owned ipv4 pool to use for this load balancer"
  type        = string
  default     = null
}

variable "desync_mitigation_mode" {
  description = "(Optional) Determines how the load balancer handles requests that might pose a security risk to an application due to HTTP desync. Valid values are monitor, defensive (default), strictest"
  type        = string
  default     = null
}

variable "dns_record_client_routing_policy" {
  description = "(Optional) Indicates how traffic is distributed among the load balancer Availability Zones. Possible values are any_availability_zone (default), availability_zone_affinity, or partial_availability_zone_affinity"
  type        = string
  default     = null
}

variable "drop_invalid_header_fields" {
  description = "(Optional) Indicates whether HTTP headers with header fields that are not valid are removed by the load balancer (true) or routed to targets (false)"
  type        = bool
  default     = null
}

variable "enable_cross_zone_load_balancing" {
  description = "(Optional) If true, cross-zone load balancing of the load balancer will be enabled"
  type        = bool
  default     = null
}

variable "enable_deletion_protection" {
  description = "(Optional) If true, deletion of the load balancer will be disabled via the AWS API"
  type        = bool
  default     = null
}

variable "enable_http2" {
  description = "(Optional) Indicates whether HTTP/2 is enabled in application load balancers"
  type        = bool
  default     = null
}

variable "enable_tls_version_and_cipher_suite_headers" {
  description = "(Optional) Indicates whether the two headers (x-amzn-tls-version and x-amzn-tls-cipher-suite), which contain information about the negotiated TLS version and cipher suite, are added to the client request before sending it to the target"
  type        = bool
  default     = null
}

variable "enable_xff_client_port" {
  description = "(Optional) Indicates whether the X-Forwarded-For header should preserve the source port that the client used to connect to the load balancer in application load balancers"
  type        = bool
  default     = null
}

variable "enable_waf_fail_open" {
  description = "(Optional) Indicates whether to allow a WAF-enabled load balancer to route requests to targets if it is unable to forward the request to AWS WAF"
  type        = bool
  default     = null
}

# variable "enforce_security_group_inbound_rules_on_private_link_traffic" {
#   description = "(Optional) Indicates whether inbound security group rules are enforced for traffic originating from a PrivateLink"
#   type        = string
#   default     = null
# }

variable "idle_timeout" {
  description = "(Optional) The time in seconds that the connection is allowed to be idle"
  type        = number
  default     = null
}

variable "internal" {
  description = "(Optional) The time in seconds that the connection is allowed to be idle"
  type        = bool
  default     = null
}

variable "ip_address_type" {
  description = "(Optional) The type of IP addresses used by the subnets for your load balancer. The possible values are ipv4 and dualstack"
  type        = string
  default     = null
}

variable "load_balancer_type" {
  description = "(Optional) The type of load balancer to create. Possible values are application, gateway, or network"
  type        = string
  default     = "application"
}

variable "load_balancer_name" {
  description = "(Optional) The name of the load balancer"
  type        = string
  default     = null
}

variable "name_prefix" {
  description = "(Optional) Creates a unique name beginning with the specified prefix"
  type        = string
  default     = null
}

variable "security_groups" {
  description = "(Optional) A list of security group IDs to assign to the LB"
  type        = list(string)
  default     = null
}

variable "preserve_host_header" {
  description = "(Optional) Indicates whether the Application Load Balancer should preserve the Host header in the HTTP request and send it to the target without any change"
  type        = bool
  default     = null
}

variable "subnet_mapping" {
  description = "(Optional) A subnet mapping block"
  type = list(object({
    subnet_id            = string
    allocation_id        = optional(string)
    ipv6_address         = optional(string)
    private_ipv4_address = optional(string)
  }))
  default = null
}

variable "subnets" {
  description = "(Optional) A list of subnet IDs to attach to the LB"
  type        = list(string)
  default     = null
}

variable "xff_header_processing_mode" {
  description = "Optional) Determines how the load balancer modifies the X-Forwarded-For header in the HTTP request before sending the request to the target"
  type        = string
  default     = null
}

variable "tags" {
  description = "(Optional) A map of tags to assign to the resource"
  type        = map(any)
  default     = {}
}

# Additional variables
variable "extra_tags" {
  description = "Map of extra tags"
  default     = {}
  type        = map(any)
}
variable "agency_code" {
  description = "Agency Code"
  type        = string
}
variable "project_code" {
  description = "Project Code"
  type        = string
}
variable "tier" {
  description = "Tier that the resource is in"
  type        = string
}
variable "zone" {
  description = "Zone that the resource is in"
  type        = string
}
variable "env" {
  description = "Environment that the resource is in"
  type        = string
}