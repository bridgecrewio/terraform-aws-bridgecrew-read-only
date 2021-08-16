module "readonly" {
  source      = "../../"
  org_name    = "james"
  aws_profile = "default"
  api_token   = var.api_token
}
