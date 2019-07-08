output "public_subnet_cidrs" {
  value       = module.subnets.public_subnet_cidrs
  description = "Public subnet CIDRs"
}

output "private_subnet_cidrs" {
  value       = module.subnets.private_subnet_cidrs
  description = "Private subnet CIDRs"
}

output "vpc_cidr" {
  value       = module.vpc.vpc_cidr_block
  description = "VPC CIDR"
}

output "security_group_id" {
  value       = module.elasticsearch.security_group_id
  description = "Security Group ID to control access to the Elasticsearch domain"
}

output "domain_arn" {
  value       = module.elasticsearch.domain_arn
  description = "ARN of the Elasticsearch domain"
}

output "domain_id" {
  value       = module.elasticsearch.domain_id
  description = "Unique identifier for the Elasticsearch domain"
}

output "domain_endpoint" {
  value       = module.elasticsearch.domain_endpoint
  description = "Domain-specific endpoint used to submit index, search, and data upload requests"
}

output "kibana_endpoint" {
  value       = module.elasticsearch.kibana_endpoint
  description = "Domain-specific endpoint for Kibana without https scheme"
}

output "domain_hostname" {
  value       = module.elasticsearch.domain_hostname
  description = "Elasticsearch domain hostname to submit index, search, and data upload requests"
}

output "kibana_hostname" {
  value       = module.elasticsearch.kibana_hostname
  description = "Kibana hostname"
}

output "elasticsearch_user_iam_role_name" {
  value       = module.elasticsearch.elasticsearch_user_iam_role_name
  description = "The name of the IAM role to allow access to Elasticsearch cluster"
}

output "elasticsearch_user_iam_role_arn" {
  value       = module.elasticsearch.elasticsearch_user_iam_role_arn
  description = "The ARN of the IAM role to allow access to Elasticsearch cluster"
}
