locals {
  resource_name_prefix = var.account_alias == "" ? "${var.org_name}-bc" : "${var.org_name}-${var.account_alias}"
  role_name            = "${local.resource_name_prefix}-read-bridgecrewcwssarole"
  profile_str          = var.aws_profile != null ? "--profile ${var.aws_profile}" : ""
}

data "aws_caller_identity" "caller" {}

data "aws_region" "region" {}

resource "random_uuid" "external_id" {}
