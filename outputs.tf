output "security_group_id" {
  value       = module.security_group.id
  description = "Elasticsearch Security Group ID"
}

output "security_group_arn" {
  value       = module.security_group.arn
  description = "Elasticsearch Security Group ARN"
}

output "security_group_name" {
  value       = module.security_group.name
  description = "Elasticsearch Security Group name"
}

output "domain_arn" {
  value       = join("", aws_elasticsearch_domain.default.*.arn)
  description = "ARN of the Elasticsearch domain"
}

output "domain_id" {
  value       = join("", aws_elasticsearch_domain.default.*.domain_id)
  description = "Unique identifier for the Elasticsearch domain"
}

output "domain_name" {
  value       = join("", aws_elasticsearch_domain.default.*.domain_name)
  description = "Name of the Elasticsearch domain"
}

output "domain_endpoint" {
  value       = join("", aws_elasticsearch_domain.default.*.endpoint)
  description = "Domain-specific endpoint used to submit index, search, and data upload requests"
}

output "kibana_endpoint" {
  value       = join("", aws_elasticsearch_domain.default.*.kibana_endpoint)
  description = "Domain-specific endpoint for Kibana without https scheme"
}

output "domain_hostname" {
  value       = module.domain_hostname.hostname
  description = "Elasticsearch domain hostname to submit index, search, and data upload requests"
}

output "kibana_hostname" {
  value       = module.kibana_hostname.hostname
  description = "Kibana hostname"
}

output "elasticsearch_user_iam_role_name" {
  value       = join(",", aws_iam_role.elasticsearch_user.*.name)
  description = "The name of the IAM role to allow access to Elasticsearch cluster"
}

output "elasticsearch_user_iam_role_arn" {
  value       = join(",", aws_iam_role.elasticsearch_user.*.arn)
  description = "The ARN of the IAM role to allow access to Elasticsearch cluster"
}
