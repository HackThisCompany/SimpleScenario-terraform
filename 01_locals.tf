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

# AMI Amazon Linux 2
data "aws_ami" "amazon-linux-2" {
  most_recent = true

  owners = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-2*"]
  }
}
