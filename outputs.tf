output "role_arn" {
  description = "The cross-account access role ARN for Bridgecrew"
  value       = aws_iam_role.bridgecrew_account_role.arn
}

output "customer_name" {
  description = "The customer name as defined on Bridgecrew signup"
  value       = var.org_name
}

output "role" {
  description = "The cross-account access role for Bridgecrew"
  value       = aws_iam_role.bridgecrew_account_role
}

output "template_version" {
  description = "Bridgecrew.io template version."
  value       = var.template_version
}

output "message" {
  value = data.template_file.message.rendered
}
