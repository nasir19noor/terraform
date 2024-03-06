resource "aws_lb_listener" "this" {
  dynamic "default_action" {
    for_each = [var.default_action]
    content {
      type = default_action.value.type

      dynamic "authenticate_cognito" {
        for_each = default_action.value.authenticate_cognito != null && default_action.value.type == "authenticate-cognito" ? [default_action.value.authenticate_cognito] : []
        content {
          user_pool_arn                       = authenticate_cognito.value.user_pool_arn
          user_pool_client_id                 = authenticate_cognito.value.user_pool_client_id
          user_pool_domain                    = authenticate_cognito.value.user_pool_domain
          authentication_request_extra_params = authenticate_cognito.value.authentication_request_extra_params
          on_unauthenticated_request          = authenticate_cognito.value.on_unauthenticated_request
          scope                               = authenticate_cognito.value.scope
          session_cookie_name                 = authenticate_cognito.value.session_cookie_name
          session_timeout                     = authenticate_cognito.value.session_timeout
        }
      }

      dynamic "authenticate_oidc" {
        for_each = default_action.value.authenticate_oidc != null && default_action.value.type == "authenticate-oidc" ? [default_action.value.authenticate_oidc] : []
        content {
          authorization_endpoint              = authenticate_oidc.value.authorization_endpoint
          client_id                           = authenticate_oidc.value.client_id
          client_secret                       = authenticate_oidc.value.client_secret
          issuer                              = authenticate_oidc.value.issuer
          token_endpoint                      = authenticate_oidc.value.token_endpoint
          user_info_endpoint                  = authenticate_oidc.value.user_info_endpoint
          authentication_request_extra_params = authenticate_oidc.value.authentication_request_extra_params
          on_unauthenticated_request          = authenticate_oidc.value.on_unauthenticated_request
          scope                               = authenticate_oidc.value.scope
          session_cookie_name                 = authenticate_oidc.value.session_cookie_name
          session_timeout                     = authenticate_oidc.value.session_timeout
        }
      }

      dynamic "fixed_response" {
        for_each = default_action.value.fixed_response != null && default_action.value.type == "fixed-response" ? [default_action.value.fixed_response] : []
        content {
          content_type = fixed_response.value.content_type
          message_body = fixed_response.value.message_body
          status_code  = fixed_response.value.status_code
        }
      }

      dynamic "forward" {
        for_each = default_action.value.forward != null && default_action.value.type == "forward" ? [default_action.value.forward] : []
        content {
          dynamic "target_group" {
            for_each = forward.value.target_group != null ? forward.value.target_group : []
            content {
              arn    = target_group.value.arn
              weight = target_group.value.weight
            }
          }

          dynamic "stickiness" {
            for_each = forward.value.stickiness != null ? [forward.value.stickiness] : []
            content {
              duration = stickiness.value.duration
              enabled  = stickiness.value.enabled
            }
          }
        }
      }

      order = default_action.value.order

      dynamic "redirect" {
        for_each = default_action.value.redirect != null && default_action.value.type == "redirect" ? [default_action.value.redirect] : []
        content {
          status_code = redirect.value.status_code
          host        = redirect.value.host
          path        = redirect.value.path
          port        = redirect.value.port
          protocol    = redirect.value.protocol
          query       = redirect.value.query
        }
      }

      target_group_arn = default_action.value.target_group_arn
    }
  }

  load_balancer_arn = var.load_balancer_arn
  alpn_policy       = var.alpn_policy
  certificate_arn   = var.certificate_arn

  # dynamic "mutual_authentication" {
  #   for_each = var.mutual_authentication != null ? [var.mutual_authentication] : []
  #   content {
  #     mode                             = mutual_authenctication.value.mode
  #     trust_store_arn                  = mutual_authenctication.value.trust_store_arn
  #     ignore_client_certificate_expiry = mutual_authenctication.value.ignore_client_certificate_expiry
  #   }
  # }

  port       = var.port
  protocol   = var.protocol
  ssl_policy = var.ssl_policy
  tags       = var.tags
}