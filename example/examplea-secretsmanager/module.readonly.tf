module "readonly" {
  source      = "../../"
  org_name    = "jameswoolfen"
  aws_profile = "default"
  api_token   = ""
  //api_token   = jsondecode(data.aws_secretsmanager_secret_version.api_token.secret_string)["/bridgecrew/api_token"]
}
