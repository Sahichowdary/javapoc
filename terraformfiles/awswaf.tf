resource "aws_wafv2_web_acl" "waf_poc" {
  name        = "awswaf_poc_java"
  description = "Example of a managed rule."
  scope       = "CLOUDFRONT"

  default_action {
    allow {}
  }

  rule {
    name     = "rule-1"
    priority = 1

    override_action {
      count {}
    }

    statement {
      managed_rule_group_statement {
        name        = "AWSManagedRulesCommonRuleSet"
        vendor_name = "AWS"

        rule_action_override {
          action_to_use {
            count {}
          }

          name = "SizeRestrictions_QUERYSTRING"
        }

        rule_action_override {
          action_to_use {
            count {}
          }

          name = "NoUserAgent_HEADER"
        }

        scope_down_statement {
          geo_match_statement {
            country_codes = ["US", "NL"]
          }
        }
      }
    }

 #   token_domains = ["mywebsite.com", "myotherwebsite.com"]

    visibility_config {
      cloudwatch_metrics_enabled = false
      metric_name                = "friendly-rule-metric-name"
      sampled_requests_enabled   = false
    }
  }

  tags = {
    Tag1 = "Value1"
    Tag2 = "Value2"
  }
}

resource "aws_wafv2_web_acl_association" "wafcdnacl" {
  resource_arn = aws_cloudfront_distribution.cdnpocjava.arn
  web_acl_arn  = aws_wafv2.waf_poc.arn
}
