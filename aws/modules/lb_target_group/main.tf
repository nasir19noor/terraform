resource "aws_lb_target_group" "this" {
  connection_termination = var.connection_termination
  deregistration_delay   = var.deregistration_delay

  dynamic "health_check" {
    for_each = var.health_check != null ? [var.health_check] : []
    content {
      enabled             = health_check.value.enabled
      healthy_threshold   = health_check.value.healthy_threshold
      interval            = health_check.value.interval
      matcher             = health_check.value.matcher
      path                = health_check.value.path
      port                = health_check.value.port
      protocol            = health_check.value.protocol
      timeout             = health_check.value.timeout
      unhealthy_threshold = health_check.value.unhealthy_threshold
    }
  }

  lambda_multi_value_headers_enabled = var.lambda_multi_value_headers_enabled
  load_balancing_algorithm_type      = var.load_balancing_algorithm_type
  load_balancing_cross_zone_enabled  = var.load_balancing_cross_zone_enabled
  name_prefix                        = var.name_prefix
  name                               = "${var.project_code}-sg-${var.env}-${var.zone}-${var.target_group_name}"
  port                               = var.port
  preserve_client_ip                 = var.preserve_client_ip
  protocol_version                   = var.protocol_version
  protocol                           = var.protocol
  proxy_protocol_v2                  = var.proxy_protocol_v2
  slow_start                         = var.slow_start

  dynamic "stickiness" {
    for_each = var.stickiness != null ? [var.stickiness] : []
    content {
      cookie_duration = stickiness.value.cookie_duration
      cookie_name     = stickiness.value.cookie_name
      enabled         = stickiness.value.enabled
      type            = stickiness.value.type
    }

  }

  dynamic "target_failover" {
    for_each = var.target_failover != null ? [var.target_failover] : []
    content {
      on_deregistration = target_failover.value.on_deregistration
      on_unhealthy      = target_failover.value.on_unhealthy
    }
  }

  dynamic "target_health_state" {
    for_each = var.target_health_state != null ? [var.target_health_state] : []
    content {
      enable_unhealthy_connection_termination = target_health_state.value.enable_unhealthy_connection_termination
    }
  }

  target_type     = var.target_type
  ip_address_type = var.ip_address_type
  vpc_id          = var.vpc_id
  tags = merge({
    zone         = var.zone
    tier         = var.tier
    agency-code  = var.agency_code
    project-code = var.project_code
    env          = var.env
  }, var.extra_tags)
}

resource "aws_lb_target_group_attachment" "this" {
  target_group_arn  = aws_lb_target_group.this.arn
  target_id         = var.target_id
  availability_zone = var.availability_zone
  port              = var.target_port
}