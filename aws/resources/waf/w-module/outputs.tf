output "web_acl_name" {
  description = "The name of the WAFv2 WebACL."
  value       = module.waf.web_acl_name
}

output "web_acl_arn" {
  description = "The ARN of the WAFv2 WebACL."
  value       = module.waf.web_acl_arn
}

output "web_acl_id" {
  description = "The ID of the WAFv2 WebACL."
  value       = module.waf.web_acl_id
}