# General
locals {
  region     = "eu-west-1"
  account_id = data.aws_caller_identity.current.account_id
}
data "aws_caller_identity" "current" {}

# Tags
locals {
  Project  = "TFG"
  Scenario = "SimpleScenario"
}

# Specific
locals {
  domain_name = "hackthiscompany.com"
}

