output "role_arn" {
  description = "The cross-account access role ARN for Bridgecrew"
  value       = aws_iam_role.bridgecrew_account_role.arn
}

output "customer_name" {
  description = "The customer name as defined on Bridgecrew signup"
  value       = var.company_name
}

output "template_version" {
  description = "Bridgecrew.io template version."
  value       = "1.0"
}
