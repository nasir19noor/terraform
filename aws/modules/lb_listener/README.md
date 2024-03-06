## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 5.23.1 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_lb_listener.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb_listener) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_alpn_policy"></a> [alpn\_policy](#input\_alpn\_policy) | (Optional) Name of the Application-Layer Protocol Negotiation (ALPN) policy | `string` | `null` | no |
| <a name="input_certificate_arn"></a> [certificate\_arn](#input\_certificate\_arn) | (Optional) ARN of the default SSL server certificate | `string` | `null` | no |
| <a name="input_default_action"></a> [default\_action](#input\_default\_action) | (Required) Configuration block for default actions | <pre>object({<br>    type = string<br><br>    authenticate_cognito = optional(object({<br>      user_pool_arn                       = string<br>      user_pool_client_id                 = string<br>      user_pool_domain                    = string<br>      authentication_request_extra_params = optional(map(string))<br>      on_unauthenticated_request          = optional(string)<br>      scope                               = optional(string)<br>      session_cookie_name                 = optional(string)<br>      session_timeout                     = optional(number)<br>    }))<br><br>    authenticate_oidc = optional(object({<br>      authorization_endpoint              = string<br>      client_id                           = string<br>      client_secret                       = string<br>      issuer                              = string<br>      token_endpoint                      = string<br>      user_info_endpoint                  = string<br>      authentication_request_extra_params = optional(map(string))<br>      on_unauthenticated_request          = optional(string)<br>      scope                               = optional(string)<br>      session_cookie_name                 = optional(string)<br>      session_timeout                     = optional(number)<br>    }))<br><br>    fixed_response = optional(object({<br>      content_type = string<br>      message_body = optional(string)<br>      status_code  = optional(number)<br>    }))<br><br>    forward = optional(object({<br>      target_group = set(object({<br>        arn    = string<br>        weight = optional(string)<br>      }))<br>      stickiness = optional(object({<br>        duration = number<br>        enabled  = optional(bool)<br>      }))<br>    }))<br><br>    order = optional(number)<br><br>    redirect = optional(object({<br>      status_code = number<br>      host        = optional(string)<br>      path        = optional(string)<br>      port        = optional(number)<br>      protocol    = optional(string)<br>      query       = optional(string)<br>    }))<br><br>    target_group_arn = optional(string)<br>  })</pre> | n/a | yes |
| <a name="input_load_balancer_arn"></a> [load\_balancer\_arn](#input\_load\_balancer\_arn) | (Required, Forces New Resource) ARN of the load balancer | `string` | n/a | yes |
| <a name="input_port"></a> [port](#input\_port) | (Optional) Port on which the load balancer is listening | `number` | `null` | no |
| <a name="input_protocol"></a> [protocol](#input\_protocol) | (Optional) Protocol for connections from clients to the load balancer | `string` | `null` | no |
| <a name="input_ssl_policy"></a> [ssl\_policy](#input\_ssl\_policy) | (Optional) Name of the SSL Policy for the listener | `string` | `null` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | (Optional) A map of tags to assign to the resource | `map(string)` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_arn"></a> [arn](#output\_arn) | ARN of the listener (matches id) |
| <a name="output_id"></a> [id](#output\_id) | ARN of the listener (matches arn) |
| <a name="output_tags_all"></a> [tags\_all](#output\_tags\_all) | A map of tags assigned to the resource |
