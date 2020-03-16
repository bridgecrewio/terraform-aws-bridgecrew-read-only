locals {
  resource_name_prefix  = var.account_alias == "" ? "${var.company_name}-bc" : "${var.company_name}-${var.account_alias}"
  bridgecrew_account_id = "090772183824"
  bridgecrew_sns_topic  = "arn:aws:sns:${data.aws_region.region.name}:${local.bridgecrew_account_id}:handle-customer-actionsnimtest"
  profile_str           = var.aws_profile != null ? "--profile ${var.aws_profile}" : ""
}

data aws_caller_identity "caller" {}

data aws_region "region" {}

resource random_string "external_id" {
  length  = 6
  lower   = false
  special = false
}
