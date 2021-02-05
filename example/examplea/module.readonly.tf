module "readonly" {
  source                = "../../"
  org_name              = "jameswoolfen"
  aws_profile           = "default"
  api_token             = "0dd2adb3-4569-54dc-8383-6642319e1886"
  bridgecrew_account_id = "619572639823"
  topic_name            = "handle-customer-actionsjimbo"
}
