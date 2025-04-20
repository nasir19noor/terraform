resource "aws_lb" "this" {
  dynamic "access_logs" {
    for_each = var.access_logs != null ? [var.access_logs] : []
    content {
      bucket  = access_logs.value.bucket
      enabled = access_logs.value.enabled
      prefix  = access_logs.value.prefix
    }
  }

  # dynamic "connection_logs" {
  #   for_each = var.connection_logs != null ? [var.connection_logs] : []
  #   content {
  #     bucket  = connection_logs.value.bucket
  #     enabled = connection_logs.value.enabled
  #     prefix  = connection_logs.value.prefix
  #   }
  # }

  customer_owned_ipv4_pool                    = var.customer_owned_ipv4_pool
  desync_mitigation_mode                      = var.desync_mitigation_mode
  dns_record_client_routing_policy            = var.dns_record_client_routing_policy
  drop_invalid_header_fields                  = var.drop_invalid_header_fields
  enable_cross_zone_load_balancing            = var.enable_cross_zone_load_balancing
  enable_deletion_protection                  = var.enable_deletion_protection
  enable_http2                                = var.enable_http2
  enable_tls_version_and_cipher_suite_headers = var.enable_tls_version_and_cipher_suite_headers
  enable_xff_client_port                      = var.enable_xff_client_port
  enable_waf_fail_open                        = var.enable_waf_fail_open
  # enforce_security_group_inbound_rules_on_private_link_traffic = var.enforce_security_group_inbound_rules_on_private_link_traffic
  idle_timeout         = var.idle_timeout
  internal             = var.internal
  ip_address_type      = var.ip_address_type
  load_balancer_type   = var.load_balancer_type
  name                 = "${var.project_code}-subnet-${var.env}-${var.zone}-${var.load_balancer_name}"
  name_prefix          = var.name_prefix
  security_groups      = var.security_groups
  preserve_host_header = var.preserve_host_header

  dynamic "subnet_mapping" {
    for_each = var.subnet_mapping != null ? var.subnet_mapping : []
    content {
      subnet_id            = subnet_mapping.value.subnet_id
      allocation_id        = subnet_mapping.value.allocation_id
      ipv6_address         = subnet_mapping.value.ipv6_address
      private_ipv4_address = subnet_mapping.value.private_ipv4_address
    }
  }

  subnets                    = var.subnets
  xff_header_processing_mode = var.xff_header_processing_mode
  tags = merge({
    zone         = var.zone
    tier         = var.tier
    agency-code  = var.agency_code
    project-code = var.project_code
    env          = var.env
  }, var.extra_tags)
}
