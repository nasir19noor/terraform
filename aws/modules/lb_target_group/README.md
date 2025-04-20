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
| [aws_lb_target_group.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb_target_group) | resource |
| [aws_lb_target_group_attachment.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb_target_group_attachment) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_agency_code"></a> [agency\_code](#input\_agency\_code) | Agency Code | `string` | n/a | yes |
| <a name="input_availability_zone"></a> [availability\_zone](#input\_availability\_zone) | (Optional) The Availability Zone where the IP address of the target is to be registered | `string` | `null` | no |
| <a name="input_connection_termination"></a> [connection\_termination](#input\_connection\_termination) | (Optional) Whether to terminate connections at the end of the deregistration timeout on Network Load Balancers | `bool` | `null` | no |
| <a name="input_deregistration_delay"></a> [deregistration\_delay](#input\_deregistration\_delay) | (Optional) Amount time for Elastic Load Balancing to wait before changing the state of a deregistering target from draining to unused | `number` | `null` | no |
| <a name="input_env"></a> [env](#input\_env) | Environment that the resource is in | `string` | n/a | yes |
| <a name="input_extra_tags"></a> [extra\_tags](#input\_extra\_tags) | Map of extra tags | `map(any)` | `{}` | no |
| <a name="input_health_check"></a> [health\_check](#input\_health\_check) | (Optional, Maximum of 1) Health Check configuration block | <pre>object({<br>    enabled             = optional(bool)<br>    healthy_threshold   = optional(number)<br>    interval            = optional(number)<br>    matcher             = optional(number)<br>    path                = optional(string)<br>    port                = optional(number)<br>    protocol            = optional(string)<br>    timeout             = optional(number)<br>    unhealthy_threshold = optional(number)<br>  })</pre> | `null` | no |
| <a name="input_ip_address_type"></a> [ip\_address\_type](#input\_ip\_address\_type) | (Optional, forces new resource) The type of IP addresses used by the target group, only supported when target type is set to ip. Possible values are ipv4 or ipv6 | `string` | `null` | no |
| <a name="input_lambda_multi_value_headers_enabled"></a> [lambda\_multi\_value\_headers\_enabled](#input\_lambda\_multi\_value\_headers\_enabled) | (Optional) Whether the request and response headers exchanged between the load balancer and the Lambda function include arrays of values or strings | `bool` | `null` | no |
| <a name="input_load_balancing_algorithm_type"></a> [load\_balancing\_algorithm\_type](#input\_load\_balancing\_algorithm\_type) | (Optional) Determines how the load balancer selects targets when routing requests | `string` | `null` | no |
| <a name="input_load_balancing_cross_zone_enabled"></a> [load\_balancing\_cross\_zone\_enabled](#input\_load\_balancing\_cross\_zone\_enabled) | (Optional) Indicates whether cross zone load balancing is enabled | `bool` | `null` | no |
| <a name="input_name_prefix"></a> [name\_prefix](#input\_name\_prefix) | (Optional, Forces new resource) Creates a unique name beginning with the specified prefix | `string` | `null` | no |
| <a name="input_port"></a> [port](#input\_port) | (Optional) Port on which targets receive traffic, unless overridden when registering a specific target | `string` | `null` | no |
| <a name="input_preserve_client_ip"></a> [preserve\_client\_ip](#input\_preserve\_client\_ip) | (Optional) Whether client IP preservation is enabled | `bool` | `null` | no |
| <a name="input_project_code"></a> [project\_code](#input\_project\_code) | Project Code | `string` | n/a | yes |
| <a name="input_protocol"></a> [protocol](#input\_protocol) | (Optional) Protocol to use for routing traffic to the targets. Should be one of GENEVE, HTTP, HTTPS, TCP, TCP\_UDP, TLS, or UDP | `string` | `null` | no |
| <a name="input_protocol_version"></a> [protocol\_version](#input\_protocol\_version) | (Optional) Only applicable when protocol is HTTP or HTTPS | `string` | `null` | no |
| <a name="input_proxy_protocol_v2"></a> [proxy\_protocol\_v2](#input\_proxy\_protocol\_v2) | (Optional) Whether to enable support for proxy protocol v2 on Network Load Balancers | `string` | `null` | no |
| <a name="input_slow_start"></a> [slow\_start](#input\_slow\_start) | (Optional) Amount time for targets to warm up before the load balancer sends them a full share of requests | `string` | `null` | no |
| <a name="input_stickiness"></a> [stickiness](#input\_stickiness) | (Optional, Maximum of 1) Stickiness configuration block | <pre>object({<br>    cookie_duration = optional(number)<br>    cookie_name     = optional(string)<br>    enabled         = optional(bool)<br>    type            = optional(string)<br>  })</pre> | `null` | no |
| <a name="input_target_failover"></a> [target\_failover](#input\_target\_failover) | (Optional) Target failover block | <pre>object({<br>    on_deregistration = optional(string)<br>    on_unhealthy      = optional(string)<br>  })</pre> | `null` | no |
| <a name="input_target_group_name"></a> [target\_group\_name](#input\_target\_group\_name) | (Optional, Forces new resource) Name of the target group | `string` | `null` | no |
| <a name="input_target_health_state"></a> [target\_health\_state](#input\_target\_health\_state) | (Optional) Target health state block | <pre>object({<br>    enable_unhealthy_connection_termination = optional(bool)<br>  })</pre> | `null` | no |
| <a name="input_target_id"></a> [target\_id](#input\_target\_id) | (Required) The ID of the target. This is the Instance ID for an instance, or the container ID for an ECS container | `string` | n/a | yes |
| <a name="input_target_port"></a> [target\_port](#input\_target\_port) | (Optional) The port on which targets receive traffic | `number` | `null` | no |
| <a name="input_target_type"></a> [target\_type](#input\_target\_type) | (Optional, Forces new resource) Type of target that you must specify when registering targets with this target group | `string` | `null` | no |
| <a name="input_tier"></a> [tier](#input\_tier) | Tier that the resource is in | `string` | n/a | yes |
| <a name="input_vpc_id"></a> [vpc\_id](#input\_vpc\_id) | (Optional, Forces new resource) Identifier of the VPC in which to create the target group | `string` | `null` | no |
| <a name="input_zone"></a> [zone](#input\_zone) | Zone that the resource is in | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_arn"></a> [arn](#output\_arn) | The ARN of the Target Group |
| <a name="output_arn_suffix"></a> [arn\_suffix](#output\_arn\_suffix) | The ARN suffix for use with CloudWatch Metrics |
| <a name="output_id"></a> [id](#output\_id) | A unique identifier for the attachment |
| <a name="output_name"></a> [name](#output\_name) | The name of the Target Group |
| <a name="output_tags_all"></a> [tags\_all](#output\_tags\_all) | A map of tags assigned to the resource |
