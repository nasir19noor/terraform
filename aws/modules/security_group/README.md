## Requirements

No requirements.

## Usage

```hcl
module "security_group" {
  source = "path/o/module

  security_group_name   = "postgres"
  description           = "Security group PostgreSQL"
  vpc_id                = local.vpc_app_id
  ingress               = [
    {
      from_port   = 5432
      to_port     = 5432
      protocol    = "tcp"
      description = "PostgreSQL access from within VPC"
      cidr_blocks = "10.0.0.0/8"
    }    
  ]
  egress                = [
    {
      from_port        = 0
      to_port          = 0
      protocol         = "-1"
      cidr_blocks      = ["0.0.0.0/0"]
      description      = "Allow all outbound traffic"
    }
  ]
  revoke_rules_on_delete = true
}
```

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 5.23.1 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_security_group.security_group_example](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_description"></a> [description](#input\_description) | (Optional, Forces new resource) Security group description | `string` | `null` | no |
| <a name="input_egress"></a> [egress](#input\_egress) | (Optional, VPC only) Configuration block for egress rules | <pre>list(object({<br>    from_port        = string<br>    to_port          = string<br>    cidr_blocks      = optional(list(string))<br>    description      = optional(string)<br>    ipv6_cidr_blocks = optional(list(string))<br>    prefix_list_ids  = optional(list(string))<br>    protocol         = optional(string)<br>    security_groups  = optional(list(string))<br>    self             = optional(bool)<br>  }))</pre> | `null` | no |
| <a name="input_ingress"></a> [ingress](#input\_ingress) | (Optional) Configuration block for ingress rules | <pre>list(object({<br>    from_port        = string<br>    to_port          = string<br>    protocol         = string<br>    cidr_blocks      = optional(list(string))<br>    description      = optional(string)<br>    ipv6_cidr_blocks = optional(list(string))<br>    prefix_list_ids  = optional(list(string))<br>    security_groups  = optional(list(string))<br>    self             = optional(bool)<br>  }))</pre> | `null` | no |
| <a name="input_revoke_rules_on_delete"></a> [revoke\_rules\_on\_delete](#input\_revoke\_rules\_on\_delete) | (Optional) Instruct Terraform to revoke all of the Security Groups attached ingress and egress rules before deleting the rule itself | `string` | `null` | no |
| <a name="input_security_group_name"></a> [security\_group\_name](#input\_security\_group\_name) | (Optional, Forces new resource) Name of the security group | `string` | `null` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | (Optional) Map of tags to assign to the resource | `map(string)` | `null` | no |
| <a name="input_vpc_id"></a> [vpc\_id](#input\_vpc\_id) | (Optional, Forces new resource) VPC ID | `string` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_arn"></a> [arn](#output\_arn) | ARN of the security group |
| <a name="output_security_group_id"></a> [security\_group\_id](#output\_security\_group\_id) | ID of the security group |

