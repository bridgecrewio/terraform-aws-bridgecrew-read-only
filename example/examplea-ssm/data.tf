data "aws_ssm_parameter" "api_token" {
  provider = aws.secret
  name     = "/bridgecrew/api_token"
}

provider "aws" {
  profile = var.profile
  alias   = "secret"
  region  = "eu-west-1"
}


variable "profile" {
  default = "default"
}
