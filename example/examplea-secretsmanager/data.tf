data "aws_secretsmanager_secret" "api_token" {
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

data "aws_secretsmanager_secret_version" "api_token" {
  provider  = aws.secret
  secret_id = data.aws_secretsmanager_secret.api_token.arn
}
