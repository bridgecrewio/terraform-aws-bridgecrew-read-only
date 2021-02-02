locals {
  resource_name_prefix = var.account_alias == "" ? "${var.org_name}-bc" : "${var.org_name}-${var.account_alias}"
  role_name            = "${local.resource_name_prefix}-read-bridgecrewcwssarole"
  bridgecrew_sns_topic = "arn:aws:sns:${data.aws_region.region.name}:${var.bridgecrew_account_id}:${var.topic_name}"
  profile_str          = var.aws_profile != null ? "--profile ${var.aws_profile}" : ""
}

data "aws_caller_identity" "caller" {}

data "aws_region" "region" {}

resource "random_uuid" "external_id" {}
