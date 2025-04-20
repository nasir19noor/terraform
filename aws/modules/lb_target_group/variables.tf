# variables for aws_lb_target_group
variable "connection_termination" {
  description = "(Optional) Whether to terminate connections at the end of the deregistration timeout on Network Load Balancers"
  type        = bool
  default     = null
}

variable "deregistration_delay" {
  description = "(Optional) Amount time for Elastic Load Balancing to wait before changing the state of a deregistering target from draining to unused"
  type        = number
  default     = null
}

variable "health_check" {
  description = "(Optional, Maximum of 1) Health Check configuration block"
  type = object({
    enabled             = optional(bool)
    healthy_threshold   = optional(number)
    interval            = optional(number)
    matcher             = optional(number)
    path                = optional(string)
    port                = optional(number)
    protocol            = optional(string)
    timeout             = optional(number)
    unhealthy_threshold = optional(number)
  })
  default = null
}

variable "lambda_multi_value_headers_enabled" {
  description = "(Optional) Whether the request and response headers exchanged between the load balancer and the Lambda function include arrays of values or strings"
  type        = bool
  default     = null
}

variable "load_balancing_algorithm_type" {
  description = "(Optional) Determines how the load balancer selects targets when routing requests"
  type        = string
  default     = null
}

variable "load_balancing_cross_zone_enabled" {
  description = "(Optional) Indicates whether cross zone load balancing is enabled"
  type        = bool
  default     = null
}

variable "name_prefix" {
  description = "(Optional, Forces new resource) Creates a unique name beginning with the specified prefix"
  type        = string
  default     = null
}

variable "target_group_name" {
  description = "(Optional, Forces new resource) Name of the target group"
  type        = string
  default     = null
}

variable "port" {
  description = "(Optional) Port on which targets receive traffic, unless overridden when registering a specific target"
  type        = string
  default     = null
}

variable "preserve_client_ip" {
  description = "(Optional) Whether client IP preservation is enabled"
  type        = bool
  default     = null
}

variable "protocol_version" {
  description = "(Optional) Only applicable when protocol is HTTP or HTTPS"
  type        = string
  default     = null
}

variable "protocol" {
  description = "(Optional) Protocol to use for routing traffic to the targets. Should be one of GENEVE, HTTP, HTTPS, TCP, TCP_UDP, TLS, or UDP"
  type        = string
  default     = null
}

variable "proxy_protocol_v2" {
  description = "(Optional) Whether to enable support for proxy protocol v2 on Network Load Balancers"
  type        = string
  default     = null
}

variable "slow_start" {
  description = "(Optional) Amount time for targets to warm up before the load balancer sends them a full share of requests"
  type        = string
  default     = null
}

variable "stickiness" {
  description = "(Optional, Maximum of 1) Stickiness configuration block"
  type = object({
    cookie_duration = optional(number)
    cookie_name     = optional(string)
    enabled         = optional(bool)
    type            = optional(string)
  })
  default = null
}

variable "target_failover" {
  description = "(Optional) Target failover block"
  type = object({
    on_deregistration = optional(string)
    on_unhealthy      = optional(string)
  })
  default = null
}

variable "target_health_state" {
  description = "(Optional) Target health state block"
  type = object({
    enable_unhealthy_connection_termination = optional(bool)
  })
  default = null
}

variable "target_type" {
  description = "(Optional, Forces new resource) Type of target that you must specify when registering targets with this target group"
  type        = string
  default     = null
}

variable "ip_address_type" {
  description = "(Optional, forces new resource) The type of IP addresses used by the target group, only supported when target type is set to ip. Possible values are ipv4 or ipv6"
  type        = string
  default     = null
}

variable "vpc_id" {
  description = "(Optional, Forces new resource) Identifier of the VPC in which to create the target group"
  type        = string
  default     = null
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

# variables for aws_lb_target_group_attachment
variable "target_id" {
  description = "(Required) The ID of the target. This is the Instance ID for an instance, or the container ID for an ECS container"
  type        = string
}

variable "availability_zone" {
  description = "(Optional) The Availability Zone where the IP address of the target is to be registered"
  type        = string
  default     = null
}

variable "target_port" {
  description = "(Optional) The port on which targets receive traffic"
  type        = number
  default     = null
}