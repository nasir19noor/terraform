resource "aws_security_group" "security_group" {
  name        = var.security_group_name
  description = var.description

  dynamic "ingress" {
    for_each = var.ingress != null ? var.ingress : []
    content {
      from_port        = ingress.value["from_port"]
      to_port          = ingress.value["to_port"]
      protocol         = ingress.value["protocol"]
      cidr_blocks      = ingress.value["cidr_blocks"]
      description      = ingress.value["description"]
      ipv6_cidr_blocks = ingress.value["ipv6_cidr_blocks"]
      prefix_list_ids  = ingress.value["prefix_list_ids"]
      security_groups  = ingress.value["security_groups"]
      self             = ingress.value["self"]
    }
  }

  dynamic "egress" {
    for_each = var.egress != null ? var.egress : []
    content {
      from_port        = egress.value["from_port"]
      to_port          = egress.value["to_port"]
      cidr_blocks      = egress.value["cidr_blocks"]
      description      = egress.value["description"]
      ipv6_cidr_blocks = egress.value["ipv6_cidr_blocks"]
      prefix_list_ids  = egress.value["prefix_list_ids"]
      protocol         = egress.value["protocol"]
      security_groups  = egress.value["security_groups"]
      self             = egress.value["self"]
    }
  }

  revoke_rules_on_delete = var.revoke_rules_on_delete
  tags                   = var.tags
  vpc_id                 = var.vpc_id
}