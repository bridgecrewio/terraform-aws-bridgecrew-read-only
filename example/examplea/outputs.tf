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
