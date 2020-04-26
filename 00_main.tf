provider "aws" {
    region = local.region
}
terraform {
  backend "s3" {
    bucket                  = "hackthiscompany-tfstate"
    workspace_key_prefix    = "Workspace-SimpleScenario"
    key                     = "state.tfstate"
    region                  = "eu-west-1"
    encrypt                 = true
  }
}