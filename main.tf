locals {
  resource_name_prefix  = var.account_alias == "" ? "${var.org_name}-bc" : "${var.org_name}-${var.account_alias}"
  bridgecrew_account_id = "890234264427"
  bridgecrew_sns_topic  = "arn:aws:sns:${data.aws_region.region.name}:${local.bridgecrew_account_id}:handle-customer-actions"
  profile_str           = var.aws_profile != null ? "--profile ${var.aws_profile}" : ""
}

data "aws_caller_identity" "caller" {}

data "aws_region" "region" {}

resource "random_uuid" "external_id" {}
