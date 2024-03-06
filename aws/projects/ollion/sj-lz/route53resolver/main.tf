locals {
  account_id_dns_hub = "647459380434"
  lz_config          = yamldecode(file("../lzconfig.yaml"))
}

module "inbound-resolver" {
  source             = "../../../../modules/route53-resolver"
  name               = var.inbound_resolver_endpoint_name
  direction          = "INBOUND"
  security_group_ids = ["sg-a675aec0"]
  subnets            = ["subnet-f873b59f", "subnet-f826d3b1"]
}

module "outbound-resolver" {
  source             = "../../../../modules/route53-resolver"
  name               = var.outbound_resolver_endpoint_name
  direction          = "OUTBOUND"
  security_group_ids = ["sg-a675aec0"]
  subnets            = ["subnet-f873b59f", "subnet-f826d3b1"]
  vpc_ids            = ["vpc-ea57648e"]
  create_rule        = var.create_rule
  target_ips         = module.inbound-resolver.resolver_endpoint_ips
  rule_type          = var.rule_type
  domain_name        = local.lz_config.network.dnshub.resolver.domain_name
  rule_name          = var.rule_name
}

module "ram" {
  source            = "../../../../modules/ram-dns"
  accounts_id       = ["060573715979"]
  resolver_rule_arn = module.outbound-resolver.rule_arn
}

resource "aws_route53_resolver_dnssec_config" "dnssec" {
  resource_id = "vpc-ea57648e"
}