module "waf" {
  source = "../../../modules/waf"

  name_prefix = var.name
  alb_arn     = "arn:aws:elasticloadbalancing:ap-southeast-1:003866745935:loadbalancer/app/lb-nasir/70308ef6adfa902f"

  allow_default_action = true

  create_alb_association = true

  visibility_config = {
    cloudwatch_metrics_enabled = false
    metric_name                = "test-waf-setup-waf-main-metrics"
    sampled_requests_enabled   = false
  }

  rules = [
    {
      name     = "AWSManagedRulesCommonRuleSet-rule-1"
      priority = "1"

      override_action = "none"

      visibility_config = {
        cloudwatch_metrics_enabled = false
        metric_name                = "AWSManagedRulesCommonRuleSet-metric"
        sampled_requests_enabled   = false
      }

      managed_rule_group_statement = {
        name        = "AWSManagedRulesCommonRuleSet"
        vendor_name = "AWS"
      }
    },
    {
      name     = "AWSManagedRulesKnownBadInputsRuleSet-rule-2"
      priority = "2"

      override_action = "count"

      visibility_config = {
        cloudwatch_metrics_enabled = false
        metric_name                = "AWSManagedRulesKnownBadInputsRuleSet-metric"
        sampled_requests_enabled   = false
      }

      managed_rule_group_statement = {
        name        = "AWSManagedRulesKnownBadInputsRuleSet"
        vendor_name = "AWS"
      }
    },
    {
      # Uses an optional scope down statement to further refine what the rule is being applied to
      name     = "AWSManagedRulesPHPRuleSet-rule-3"
      priority = "3"

      override_action = "none"

      visibility_config = {
        cloudwatch_metrics_enabled = false
        metric_name                = "AWSManagedRulesPHPRuleSet-metric"
        sampled_requests_enabled   = false
      }

      managed_rule_group_statement = {
        name        = "AWSManagedRulesPHPRuleSet"
        vendor_name = "AWS"

        # Optional scope_down_statement
        scope_down_statement = {
          geo_match_statement = {
            country_codes = ["NL", "GB", "US"]
          }
        }
      }
    },
    {
      name     = "AWSManagedRulesBotControlRuleSet-rule-4"
      priority = "4"

      override_action = "none"

      visibility_config = {
        cloudwatch_metrics_enabled = false
        metric_name                = "AWSManagedRulesBotControlRuleSet-metric"
        sampled_requests_enabled   = false
      }

      managed_rule_group_statement = {
        name        = "AWSManagedRulesBotControlRuleSet"
        vendor_name = "AWS"
      }
    },
    {
      name     = "block-nl-us-traffic"
      priority = "5"
      action   = "block"

      geo_match_statement = {
        country_codes = ["NL", "US"]
      }

      visibility_config = {
        cloudwatch_metrics_enabled = false
        sampled_requests_enabled   = false
      }
    }
  ]

  tags = {
    "Environment" = "test"
  }
}