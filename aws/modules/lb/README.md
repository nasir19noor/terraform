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
| [aws_lb.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_access_logs"></a> [access\_logs](#input\_access\_logs) | (Optional) An Access Logs block | <pre>object({<br>    bucket  = string<br>    enabled = optional(bool)<br>    prefix  = optional(string)<br>  })</pre> | `null` | no |
| <a name="input_agency_code"></a> [agency\_code](#input\_agency\_code) | Agency Code | `string` | n/a | yes |
| <a name="input_customer_owned_ipv4_pool"></a> [customer\_owned\_ipv4\_pool](#input\_customer\_owned\_ipv4\_pool) | (Optional) The ID of the customer owned ipv4 pool to use for this load balancer | `string` | `null` | no |
| <a name="input_desync_mitigation_mode"></a> [desync\_mitigation\_mode](#input\_desync\_mitigation\_mode) | (Optional) Determines how the load balancer handles requests that might pose a security risk to an application due to HTTP desync. Valid values are monitor, defensive (default), strictest | `string` | `null` | no |
| <a name="input_dns_record_client_routing_policy"></a> [dns\_record\_client\_routing\_policy](#input\_dns\_record\_client\_routing\_policy) | (Optional) Indicates how traffic is distributed among the load balancer Availability Zones. Possible values are any\_availability\_zone (default), availability\_zone\_affinity, or partial\_availability\_zone\_affinity | `string` | `null` | no |
| <a name="input_drop_invalid_header_fields"></a> [drop\_invalid\_header\_fields](#input\_drop\_invalid\_header\_fields) | (Optional) Indicates whether HTTP headers with header fields that are not valid are removed by the load balancer (true) or routed to targets (false) | `bool` | `null` | no |
| <a name="input_enable_cross_zone_load_balancing"></a> [enable\_cross\_zone\_load\_balancing](#input\_enable\_cross\_zone\_load\_balancing) | (Optional) If true, cross-zone load balancing of the load balancer will be enabled | `bool` | `null` | no |
| <a name="input_enable_deletion_protection"></a> [enable\_deletion\_protection](#input\_enable\_deletion\_protection) | (Optional) If true, deletion of the load balancer will be disabled via the AWS API | `bool` | `null` | no |
| <a name="input_enable_http2"></a> [enable\_http2](#input\_enable\_http2) | (Optional) Indicates whether HTTP/2 is enabled in application load balancers | `bool` | `null` | no |
| <a name="input_enable_tls_version_and_cipher_suite_headers"></a> [enable\_tls\_version\_and\_cipher\_suite\_headers](#input\_enable\_tls\_version\_and\_cipher\_suite\_headers) | (Optional) Indicates whether the two headers (x-amzn-tls-version and x-amzn-tls-cipher-suite), which contain information about the negotiated TLS version and cipher suite, are added to the client request before sending it to the target | `bool` | `null` | no |
| <a name="input_enable_waf_fail_open"></a> [enable\_waf\_fail\_open](#input\_enable\_waf\_fail\_open) | (Optional) Indicates whether to allow a WAF-enabled load balancer to route requests to targets if it is unable to forward the request to AWS WAF | `bool` | `null` | no |
| <a name="input_enable_xff_client_port"></a> [enable\_xff\_client\_port](#input\_enable\_xff\_client\_port) | (Optional) Indicates whether the X-Forwarded-For header should preserve the source port that the client used to connect to the load balancer in application load balancers | `bool` | `null` | no |
| <a name="input_env"></a> [env](#input\_env) | Environment that the resource is in | `string` | n/a | yes |
| <a name="input_extra_tags"></a> [extra\_tags](#input\_extra\_tags) | Map of extra tags | `map(any)` | `{}` | no |
| <a name="input_idle_timeout"></a> [idle\_timeout](#input\_idle\_timeout) | (Optional) The time in seconds that the connection is allowed to be idle | `number` | `null` | no |
| <a name="input_internal"></a> [internal](#input\_internal) | (Optional) The time in seconds that the connection is allowed to be idle | `bool` | `null` | no |
| <a name="input_ip_address_type"></a> [ip\_address\_type](#input\_ip\_address\_type) | (Optional) The type of IP addresses used by the subnets for your load balancer. The possible values are ipv4 and dualstack | `string` | `null` | no |
| <a name="input_load_balancer_name"></a> [load\_balancer\_name](#input\_load\_balancer\_name) | (Optional) The name of the load balancer | `string` | `null` | no |
| <a name="input_load_balancer_type"></a> [load\_balancer\_type](#input\_load\_balancer\_type) | (Optional) The type of load balancer to create. Possible values are application, gateway, or network | `string` | `"application"` | no |
| <a name="input_name_prefix"></a> [name\_prefix](#input\_name\_prefix) | (Optional) Creates a unique name beginning with the specified prefix | `string` | `null` | no |
| <a name="input_preserve_host_header"></a> [preserve\_host\_header](#input\_preserve\_host\_header) | (Optional) Indicates whether the Application Load Balancer should preserve the Host header in the HTTP request and send it to the target without any change | `bool` | `null` | no |
| <a name="input_project_code"></a> [project\_code](#input\_project\_code) | Project Code | `string` | n/a | yes |
| <a name="input_security_groups"></a> [security\_groups](#input\_security\_groups) | (Optional) A list of security group IDs to assign to the LB | `list(string)` | `null` | no |
| <a name="input_subnet_mapping"></a> [subnet\_mapping](#input\_subnet\_mapping) | (Optional) A subnet mapping block | <pre>list(object({<br>    subnet_id            = string<br>    allocation_id        = optional(string)<br>    ipv6_address         = optional(string)<br>    private_ipv4_address = optional(string)<br>  }))</pre> | `null` | no |
| <a name="input_subnets"></a> [subnets](#input\_subnets) | (Optional) A list of subnet IDs to attach to the LB | `list(string)` | `null` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | (Optional) A map of tags to assign to the resource | `map(any)` | `{}` | no |
| <a name="input_tier"></a> [tier](#input\_tier) | Tier that the resource is in | `string` | n/a | yes |
| <a name="input_xff_header_processing_mode"></a> [xff\_header\_processing\_mode](#input\_xff\_header\_processing\_mode) | Optional) Determines how the load balancer modifies the X-Forwarded-For header in the HTTP request before sending the request to the target | `string` | `null` | no |
| <a name="input_zone"></a> [zone](#input\_zone) | Zone that the resource is in | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_arn"></a> [arn](#output\_arn) | The ARN of the load balancer |
| <a name="output_arn_suffix"></a> [arn\_suffix](#output\_arn\_suffix) | The ARN suffix for use with CloudWatch Metrics |
| <a name="output_dns_name"></a> [dns\_name](#output\_dns\_name) | The DNS name of the load balancer |
| <a name="output_id"></a> [id](#output\_id) | The ARN of the load balancer |
| <a name="output_outposts_id"></a> [outposts\_id](#output\_outposts\_id) | ID of the Outpost containing the load balancer |
| <a name="output_tags_all"></a> [tags\_all](#output\_tags\_all) | A map of tags assigned to the resource |
| <a name="output_zone_id"></a> [zone\_id](#output\_zone\_id) | A map of tags assigned to the resource |
