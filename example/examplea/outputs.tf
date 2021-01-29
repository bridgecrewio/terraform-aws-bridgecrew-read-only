output "role_arn" {
  description = "The cross-account access role ARN for Bridgecrew"
  value       = module.readonly.role_arn
}

output "customer_name" {
  description = "The customer name as defined on Bridgecrew signup"
  value       = module.readonly.customer_name
}

output "role" {
  description = "The cross-account access role for Bridgecrew"
  value       = module.readonly.role
}

output "template_version" {
  description = "Bridgecrew.io template version."
  value       = module.readonly.template_version
}

output "message" {
  value = module.readonly.message
}
