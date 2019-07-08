variable "region" {
  type        = string
  description = "AWS region"
}

variable "namespace" {
  type        = string
  description = "Namespace (e.g. `eg` or `cp`)"
}

variable "stage" {
  type        = string
  description = "Stage (e.g. `prod`, `dev`, `staging`, `infra`)"
}

variable "name" {
  type        = string
  description = "Name  (e.g. `app` or `cluster`)"
}

variable "availability_zones" {
  type        = list(string)
  description = "List of availability zones"
}

variable "instance_type" {
  type        = string
  description = "The type of the instance"
}

variable "elasticsearch_version" {
  type        = string
  description = "Version of Elasticsearch to deploy"
}

variable "instance_count" {
  type        = number
  description = "Number of data nodes in the cluster"
}

variable "zone_awareness_enabled" {
  type        = bool
  description = "Enable zone awareness for Elasticsearch cluster"
}

variable "encrypt_at_rest_enabled" {
  type        = bool
  description = "Whether to enable encryption at rest"
}

variable "dedicated_master_enabled" {
  type        = bool
  description = "Indicates whether dedicated master nodes are enabled for the cluster"
}

variable "kibana_subdomain_name" {
  type        = string
  description = "The name of the subdomain for Kibana in the DNS zone (_e.g._ `kibana`, `ui`, `ui-es`, `search-ui`, `kibana.elasticsearch`)"
}

variable "create_iam_service_linked_role" {
  type        = bool
  description = "Whether to create `AWSServiceRoleForAmazonElasticsearchService` service-linked role. Set it to `false` if you already have an ElasticSearch cluster created in the AWS account and AWSServiceRoleForAmazonElasticsearchService already exists. See https://github.com/terraform-providers/terraform-provider-aws/issues/5218 for more info"
}
