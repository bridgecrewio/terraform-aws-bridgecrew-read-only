variable "company_name" {
  description = "The name of the company the integration is for. Must be alphanumeric."
  type        = string
}

variable "account_alias" {
  description = "The alias of the account the CF is deployed in. This will be prepended to all the resources in the stack. Default is {company_name}-bc"
  type        = string
  default     = ""
}

variable "aws_profile" {
  type        = string
  description = "The profile that was used to deploy this module. If the default profile / default credentials are used, do not supply this value."
  default     = null
}
