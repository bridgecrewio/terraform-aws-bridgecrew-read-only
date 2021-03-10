module "readonly" {
  source      = "../../"
  org_name    = "jameswoolfen"
  aws_profile = "default"
  api_token   = data.aws_ssm_parameter.api_token.value
}
