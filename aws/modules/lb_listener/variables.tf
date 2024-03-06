variable "default_action" {
  description = "(Required) Configuration block for default actions"
  type = object({
    type = string

    authenticate_cognito = optional(object({
      user_pool_arn                       = string
      user_pool_client_id                 = string
      user_pool_domain                    = string
      authentication_request_extra_params = optional(map(string))
      on_unauthenticated_request          = optional(string)
      scope                               = optional(string)
      session_cookie_name                 = optional(string)
      session_timeout                     = optional(number)
    }))

    authenticate_oidc = optional(object({
      authorization_endpoint              = string
      client_id                           = string
      client_secret                       = string
      issuer                              = string
      token_endpoint                      = string
      user_info_endpoint                  = string
      authentication_request_extra_params = optional(map(string))
      on_unauthenticated_request          = optional(string)
      scope                               = optional(string)
      session_cookie_name                 = optional(string)
      session_timeout                     = optional(number)
    }))

    fixed_response = optional(object({
      content_type = string
      message_body = optional(string)
      status_code  = optional(number)
    }))

    forward = optional(object({
      target_group = set(object({
        arn    = string
        weight = optional(string)
      }))
      stickiness = optional(object({
        duration = number
        enabled  = optional(bool)
      }))
    }))

    order = optional(number)

    redirect = optional(object({
      status_code = number
      host        = optional(string)
      path        = optional(string)
      port        = optional(number)
      protocol    = optional(string)
      query       = optional(string)
    }))

    target_group_arn = optional(string)
  })
}

variable "load_balancer_arn" {
  description = "(Required, Forces New Resource) ARN of the load balancer"
  type        = string
}

variable "alpn_policy" {
  description = "(Optional) Name of the Application-Layer Protocol Negotiation (ALPN) policy"
  type        = string
  default     = null
}

variable "certificate_arn" {
  description = "(Optional) ARN of the default SSL server certificate"
  type        = string
  default     = null
}

# variable "mutual_authentication" {
#   description = "(Optional) The mutual authentication configuration information"
#   type = object({
#     mode                             = string
#     trust_store_arn                  = string
#     ignore_client_certificate_expiry = optional(bool)
#   })
#   default = null
# }

variable "port" {
  description = "(Optional) Port on which the load balancer is listening"
  type        = number
  default     = null
}

variable "protocol" {
  description = "(Optional) Protocol for connections from clients to the load balancer"
  type        = string
  default     = null
}

variable "ssl_policy" {
  description = "(Optional) Name of the SSL Policy for the listener"
  type        = string
  default     = null
}

variable "tags" {
  description = "(Optional) A map of tags to assign to the resource"
  type        = map(string)
  default     = null
}