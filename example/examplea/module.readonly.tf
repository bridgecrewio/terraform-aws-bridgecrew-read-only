module "readonly" {
  source      = "../../"
  api_token   = var.api_token
  org_name    = "testcustomer"
  aws_profile = "test"
}
