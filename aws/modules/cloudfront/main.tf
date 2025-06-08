# modules/cloudfront/main.tf

# Data source for ACM certificate (conditional)
data "aws_acm_certificate" "this" {
  count = var.acm_certificate_arn == null && var.domain_name != null ? 1 : 0
  
  domain   = var.acm_certificate_domain != null ? var.acm_certificate_domain : var.domain_name
  statuses = ["ISSUED"]
  # ACM certificates for CloudFront must be in us-east-1
  provider = aws.us_east_1
}

# Origin Access Control for S3 origins
resource "aws_cloudfront_origin_access_control" "s3_oac" {
  for_each = {
    for idx, origin in var.origins : idx => origin
    if origin.origin_type == "s3"
  }
  
  name                              = "${var.distribution_name}-oac-${each.key}"
  description                       = "Origin Access Control for ${each.value.domain_name}"
  origin_access_control_origin_type = "s3"
  signing_behavior                  = "always"
  signing_protocol                  = "sigv4"
}

resource "aws_cloudfront_distribution" "this" {
  aliases = var.domain_name != null ? [var.domain_name] : var.aliases
  
  # Dynamic origins
  dynamic "origin" {
    for_each = var.origins
    content {
      domain_name = origin.value.domain_name
      origin_id   = origin.value.origin_id
      origin_path = lookup(origin.value, "origin_path", "")
      
      # Origin Access Control for S3
      origin_access_control_id = origin.value.origin_type == "s3" ? aws_cloudfront_origin_access_control.s3_oac[origin.key].id : null
      
      # Custom origin config for non-S3 origins
      dynamic "custom_origin_config" {
        for_each = origin.value.origin_type != "s3" ? [1] : []
        content {
          http_port                = lookup(origin.value, "http_port", 80)
          https_port               = lookup(origin.value, "https_port", 443)
          origin_protocol_policy   = lookup(origin.value, "origin_protocol_policy", "https-only")
          origin_ssl_protocols     = lookup(origin.value, "origin_ssl_protocols", ["TLSv1.2"])
          origin_keepalive_timeout = lookup(origin.value, "origin_keepalive_timeout", 5)
          origin_read_timeout      = lookup(origin.value, "origin_read_timeout", 30)
        }
      }
      
      # Custom headers
      dynamic "custom_header" {
        for_each = lookup(origin.value, "custom_headers", {})
        content {
          name  = custom_header.key
          value = custom_header.value
        }
      }
    }
  }

  enabled             = var.enabled
  is_ipv6_enabled     = var.ipv6_enabled
  default_root_object = var.default_root_object
  comment             = var.comment
  price_class         = var.price_class
  web_acl_id          = var.web_acl_id

  # Default cache behavior
  default_cache_behavior {
    allowed_methods          = var.default_cache_behavior.allowed_methods
    cached_methods           = var.default_cache_behavior.cached_methods
    target_origin_id         = var.default_cache_behavior.target_origin_id
    compress                 = var.default_cache_behavior.compress
    viewer_protocol_policy   = var.default_cache_behavior.viewer_protocol_policy
    cache_policy_id          = var.default_cache_behavior.cache_policy_id
    origin_request_policy_id = var.default_cache_behavior.origin_request_policy_id
    response_headers_policy_id = var.default_cache_behavior.response_headers_policy_id
    realtime_log_config_arn  = var.default_cache_behavior.realtime_log_config_arn

    # Legacy forwarded values (only if cache_policy_id is not set)
    dynamic "forwarded_values" {
      for_each = var.default_cache_behavior.cache_policy_id == null ? [1] : []
      content {
        query_string            = var.default_cache_behavior.forward_query_string
        query_string_cache_keys = var.default_cache_behavior.query_string_cache_keys
        headers                 = var.default_cache_behavior.forward_headers
        
        cookies {
          forward           = var.default_cache_behavior.forward_cookies
          whitelisted_names = var.default_cache_behavior.cookies_whitelisted_names
        }
      }
    }

    min_ttl     = var.default_cache_behavior.min_ttl
    default_ttl = var.default_cache_behavior.default_ttl
    max_ttl     = var.default_cache_behavior.max_ttl

    # Trusted signers
    # dynamic "trusted_signers" {
    #   for_each = length(var.default_cache_behavior.trusted_signers) > 0 ? [1] : []
    #   content {
    #     enabled   = true
    #     items     = var.default_cache_behavior.trusted_signers
    #   }
    # }

    # # Trusted key groups
    # dynamic "trusted_key_groups" {
    #   for_each = length(var.default_cache_behavior.trusted_key_groups) > 0 ? [1] : []
    #   content {
    #     enabled   = true
    #     items     = var.default_cache_behavior.trusted_key_groups
    #   }
    # }

    # Lambda function associations
    dynamic "lambda_function_association" {
      for_each = var.default_cache_behavior.lambda_function_associations
      content {
        event_type   = lambda_function_association.value.event_type
        lambda_arn   = lambda_function_association.value.lambda_arn
        include_body = lambda_function_association.value.include_body
      }
    }

    # CloudFront function associations
    dynamic "function_association" {
      for_each = var.default_cache_behavior.function_associations
      content {
        event_type   = function_association.value.event_type
        function_arn = function_association.value.function_arn
      }
    }
  }

  # Ordered cache behaviors
  dynamic "ordered_cache_behavior" {
    for_each = var.ordered_cache_behaviors
    content {
      path_pattern             = ordered_cache_behavior.value.path_pattern
      allowed_methods          = ordered_cache_behavior.value.allowed_methods
      cached_methods           = ordered_cache_behavior.value.cached_methods
      target_origin_id         = ordered_cache_behavior.value.target_origin_id
      compress                 = ordered_cache_behavior.value.compress
      viewer_protocol_policy   = ordered_cache_behavior.value.viewer_protocol_policy
      cache_policy_id          = ordered_cache_behavior.value.cache_policy_id
      origin_request_policy_id = ordered_cache_behavior.value.origin_request_policy_id
      response_headers_policy_id = ordered_cache_behavior.value.response_headers_policy_id
      realtime_log_config_arn  = ordered_cache_behavior.value.realtime_log_config_arn

      # Legacy forwarded values (only if cache_policy_id is not set)
      dynamic "forwarded_values" {
        for_each = ordered_cache_behavior.value.cache_policy_id == null ? [1] : []
        content {
          query_string            = ordered_cache_behavior.value.forward_query_string
          query_string_cache_keys = ordered_cache_behavior.value.query_string_cache_keys
          headers                 = ordered_cache_behavior.value.forward_headers
          
          cookies {
            forward           = ordered_cache_behavior.value.forward_cookies
            whitelisted_names = ordered_cache_behavior.value.cookies_whitelisted_names
          }
        }
      }

      min_ttl     = ordered_cache_behavior.value.min_ttl
      default_ttl = ordered_cache_behavior.value.default_ttl
      max_ttl     = ordered_cache_behavior.value.max_ttl

      # Trusted signers
      dynamic "trusted_signers" {
        for_each = length(ordered_cache_behavior.value.trusted_signers) > 0 ? [1] : []
        content {
          enabled   = true
          items     = ordered_cache_behavior.value.trusted_signers
        }
      }

      # Trusted key groups
      dynamic "trusted_key_groups" {
        for_each = length(ordered_cache_behavior.value.trusted_key_groups) > 0 ? [1] : []
        content {
          enabled   = true
          items     = ordered_cache_behavior.value.trusted_key_groups
        }
      }

      # Lambda function associations
      dynamic "lambda_function_association" {
        for_each = ordered_cache_behavior.value.lambda_function_associations
        content {
          event_type   = lambda_function_association.value.event_type
          lambda_arn   = lambda_function_association.value.lambda_arn
          include_body = lambda_function_association.value.include_body
        }
      }

      # CloudFront function associations
      dynamic "function_association" {
        for_each = ordered_cache_behavior.value.function_associations
        content {
          event_type   = function_association.value.event_type
          function_arn = function_association.value.function_arn
        }
      }
    }
  }

  # Restrictions
  restrictions {
    geo_restriction {
      restriction_type = var.geo_restriction.restriction_type
      locations        = var.geo_restriction.locations
    }
  }

  # Viewer certificate
  viewer_certificate {
    # Use provided ACM certificate ARN, or data source, or default CloudFront certificate
    acm_certificate_arn = var.acm_certificate_arn != null ? var.acm_certificate_arn : (
      var.domain_name != null ? try(data.aws_acm_certificate.this[0].arn, null) : null
    )
    cloudfront_default_certificate = var.domain_name == null && var.acm_certificate_arn == null ? true : false
    ssl_support_method             = var.domain_name != null || var.acm_certificate_arn != null ? "sni-only" : null
    minimum_protocol_version       = var.minimum_protocol_version
  }

  # Custom error responses
  dynamic "custom_error_response" {
    for_each = var.custom_error_responses
    content {
      error_code            = custom_error_response.value.error_code
      response_code         = custom_error_response.value.response_code
      response_page_path    = custom_error_response.value.response_page_path
      error_caching_min_ttl = custom_error_response.value.error_caching_min_ttl
    }
  }

  # Logging
  dynamic "logging_config" {
    for_each = var.logging_config != null ? [var.logging_config] : []
    content {
      bucket          = logging_config.value.bucket
      prefix          = logging_config.value.prefix
      include_cookies = logging_config.value.include_cookies
    }
  }

  tags = var.tags

  # Wait for deployment
  wait_for_deployment = var.wait_for_deployment
}