# output "azure_agent_private_ip" {
#   description = "The private IP address assigned to the instance"
#   value       = module.azure_agent.private_ip
# }

# output "azure_agent_id" {
#   description = "instance id"
#   value       = module.azure_agent.id
# }

# output "tooling_private_ip" {
#   description = "The private IP address assigned to the instance"
#   value       = module.tooling.private_ip
# }

# output "tooling_id" {
#   description = "instance id"
#   value       = module.tooling.id
# }

# output "azure_agent_security_group" {
#   description = "Security Group"
#   value       = module.security_group_azure_agent.security_group_id
# }

# output "tooling_security_group" {
#   description = "Security Group"
#   value       = module.security_group_tooling.security_group_id
# }

# output "azure_agent_iam_role" {
#   description = "IAM Role name of Azure agent"
#   value       = module.azure_agent.iam_role_name
# }

# output "azure_agent_iam_role_arn" {
#   description = "IAM Role ARN of Azure agent"
#   value       = module.azure_agent.iam_role_arn
# }

# output "tooling_iam_role" {
#   description = "IAM Role name of Tooling Server"
#   value       = module.tooling.iam_role_name
# }

# output "tooling_iam_role_arn" {
#   description = "IAM Role ARN of Tooling Server"
#   value       = module.tooling.iam_role_arn
# }

# output "iam_role_arn" {
#   description = "The Amazon Resource Name (ARN) specifying the IAM role"
#   value       = try(module.azure_agent.iam_role_arn, null)
# }

