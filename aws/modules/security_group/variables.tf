variable "security_group_name" {
  description = "(Optional, Forces new resource) Name of the security group"
  type        = string
  default     = null
}

variable "description" {
  description = "(Optional, Forces new resource) Security group description"
  type        = string
  default     = null
}

variable "ingress" {
  description = "(Optional) Configuration block for ingress rules"
  type = list(object({
    from_port        = string
    to_port          = string
    protocol         = string
    cidr_blocks      = optional(list(string))
    description      = optional(string)
    ipv6_cidr_blocks = optional(list(string))
    prefix_list_ids  = optional(list(string))
    security_groups  = optional(list(string))
    self             = optional(bool)
  }))
  default = null
}

variable "egress" {
  description = "(Optional, VPC only) Configuration block for egress rules"
  type = list(object({
    from_port        = string
    to_port          = string
    cidr_blocks      = optional(list(string))
    description      = optional(string)
    ipv6_cidr_blocks = optional(list(string))
    prefix_list_ids  = optional(list(string))
    protocol         = optional(string)
    security_groups  = optional(list(string))
    self             = optional(bool)
  }))
  default = null
}

variable "revoke_rules_on_delete" {
  description = "(Optional) Instruct Terraform to revoke all of the Security Groups attached ingress and egress rules before deleting the rule itself"
  type        = string
  default     = null
}

variable "tags" {
  description = "(Optional) Map of tags to assign to the resource"
  type        = map(string)
  default     = null
}

variable "vpc_id" {
  description = "(Optional, Forces new resource) VPC ID"
  type        = string
  default     = null
}