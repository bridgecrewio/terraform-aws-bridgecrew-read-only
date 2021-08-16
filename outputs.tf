output "role_arn" {
  description = "The cross-account access role ARN for Bridgecrew"
  value       = aws_iam_role.bridgecrew_account_role.arn
}

output "customer_name" {
  description = "The customer name as defined on Bridgecrew signup"
  value       = var.org_name
}

output "topic" {
  description = "The SNS endpoint that enabled the account"
  value       = local.bridgecrew_sns_topic
}

output "role" {
  description = "The cross-account access role for Bridgecrew"
  value       = aws_iam_role.bridgecrew_account_role
}

output "message" {
  value = templatefile("${path.module}/message.json.tpl", { request_type = local.request_type, bridgecrew_sns_topic = local.bridgecrew_sns_topic, customer_name = local.customer_name, account_id = local.account_id, external_id = local.external_id, role_arn = local.role_arn, region = local.region, api_token = local.api_token })
}

output "role_name" {
  value = local.role_name
}
