variable "namespace" {
  type        = string
  default     = ""
  description = "Namespace, which could be your organization name or abbreviation, e.g. 'eg' or 'cp'"
}

variable "environment" {
  type        = string
  default     = ""
  description = "Environment, e.g. 'prod', 'staging', 'dev', 'pre-prod', 'UAT'"
}

variable "stage" {
  type        = string
  default     = ""
  description = "Stage, e.g. 'prod', 'staging', 'dev', OR 'source', 'build', 'test', 'deploy', 'release'"
}

variable "name" {
  type        = string
  default     = ""
  description = "Solution name, e.g. 'app' or 'jenkins'"
}

variable "enabled" {
  type        = bool
  default     = true
  description = "Set to false to prevent the module from creating any resources"
}

variable "delimiter" {
  type        = string
  default     = "-"
  description = "Delimiter to be used between `namespace`, `environment`, `stage`, `name` and `attributes`"
}

variable "attributes" {
  type        = list(string)
  default     = []
  description = "Additional attributes (e.g. `1`)"
}

variable "label_order" {
  type        = list(string)
  default     = []
  description = "The naming order of the id output and Name tag"
}

variable "tags" {
  type        = map(string)
  default     = {}
  description = "Additional tags (e.g. `map('BusinessUnit','XYZ')`"
}

variable "security_groups" {
  type        = list(string)
  default     = []
  description = "List of security group IDs to be allowed to connect to the cluster"
}

variable "ingress_port_range_start" {
  type        = number
  default     = 0
  description = "Start number for allowed port range. (e.g. `443`)"
}

variable "ingress_port_range_end" {
  type        = number
  default     = 65535
  description = "End number for allowed port range. (e.g. `443`)"
}

variable "allowed_cidr_blocks" {
  type        = list(string)
  default     = []
  description = "List of CIDR blocks to be allowed to connect to the cluster"
}

variable "vpc_enabled" {
  type        = bool
  description = "Set to false if ES should be deployed outside of VPC."
  default     = true
}

variable "vpc_id" {
  type        = string
  description = "VPC ID"
  default     = null
}

variable "subnet_ids" {
  type        = list(string)
  description = "VPC Subnet IDs"
  default     = []
}

variable "dns_zone_id" {
  type        = string
  default     = ""
  description = "Route53 DNS Zone ID to add hostname records for Elasticsearch domain and Kibana"
}

variable "elasticsearch_version" {
  type        = string
  default     = "7.4"
  description = "Version of Elasticsearch to deploy (_e.g._ `7.4`, `7.1`, `6.8`, `6.7`, `6.5`, `6.4`, `6.3`, `6.2`, `6.0`, `5.6`, `5.5`, `5.3`, `5.1`, `2.3`, `1.5`"
}

variable "instance_type" {
  type        = string
  default     = "t2.small.elasticsearch"
  description = "Elasticsearch instance type for data nodes in the cluster"
}

variable "instance_count" {
  type        = number
  description = "Number of data nodes in the cluster"
  default     = 4
}

variable "iam_role_arns" {
  type        = list(string)
  default     = []
  description = "List of IAM role ARNs to permit access to the Elasticsearch domain"
}

variable "iam_authorizing_role_arns" {
  type        = list(string)
  default     = []
  description = "List of IAM role ARNs to permit to assume the Elasticsearch user role"
}

variable "iam_actions" {
  type        = list(string)
  default     = []
  description = "List of actions to allow for the IAM roles, _e.g._ `es:ESHttpGet`, `es:ESHttpPut`, `es:ESHttpPost`"
}

variable "zone_awareness_enabled" {
  type        = bool
  default     = true
  description = "Enable zone awareness for Elasticsearch cluster"
}

variable "availability_zone_count" {
  type        = number
  default     = 2
  description = "Number of Availability Zones for the domain to use."
}

variable "ebs_volume_size" {
  type        = number
  description = "EBS volumes for data storage in GB"
  default     = 0
}

variable "ebs_volume_type" {
  type        = string
  default     = "gp2"
  description = "Storage type of EBS volumes"
}

variable "ebs_iops" {
  type        = number
  default     = 0
  description = "The baseline input/output (I/O) performance of EBS volumes attached to data nodes. Applicable only for the Provisioned IOPS EBS volume type"
}

variable "encrypt_at_rest_enabled" {
  type        = bool
  default     = true
  description = "Whether to enable encryption at rest"
}

variable "encrypt_at_rest_kms_key_id" {
  type        = string
  default     = ""
  description = "The KMS key ID to encrypt the Elasticsearch domain with. If not specified, then it defaults to using the AWS/Elasticsearch service KMS key"
}

variable "domain_endpoint_options_enforce_https" {
  type        = bool
  default     = false
  description = "Whether or not to require HTTPS"
}

variable "domain_endpoint_options_tls_security_policy" {
  type        = string
  default     = "Policy-Min-TLS-1-0-2019-07"
  description = "The name of the TLS security policy that needs to be applied to the HTTPS endpoint"
}


variable "log_publishing_index_enabled" {
  type        = bool
  default     = false
  description = "Specifies whether log publishing option for INDEX_SLOW_LOGS is enabled or not"
}

variable "log_publishing_search_enabled" {
  type        = bool
  default     = false
  description = "Specifies whether log publishing option for SEARCH_SLOW_LOGS is enabled or not"
}

variable "log_publishing_application_enabled" {
  type        = bool
  default     = false
  description = "Specifies whether log publishing option for ES_APPLICATION_LOGS is enabled or not"
}

variable "log_publishing_index_cloudwatch_log_group_arn" {
  type        = string
  default     = ""
  description = "ARN of the CloudWatch log group to which log for INDEX_SLOW_LOGS needs to be published"
}

variable "log_publishing_search_cloudwatch_log_group_arn" {
  type        = string
  default     = ""
  description = "ARN of the CloudWatch log group to which log for SEARCH_SLOW_LOGS needs to be published"
}

variable "log_publishing_application_cloudwatch_log_group_arn" {
  type        = string
  default     = ""
  description = "ARN of the CloudWatch log group to which log for ES_APPLICATION_LOGS needs to be published"
}

variable "automated_snapshot_start_hour" {
  type        = number
  description = "Hour at which automated snapshots are taken, in UTC"
  default     = 0
}

variable "dedicated_master_enabled" {
  type        = bool
  default     = false
  description = "Indicates whether dedicated master nodes are enabled for the cluster"
}

variable "dedicated_master_count" {
  type        = number
  description = "Number of dedicated master nodes in the cluster"
  default     = 0
}

variable "dedicated_master_type" {
  type        = string
  default     = "t2.small.elasticsearch"
  description = "Instance type of the dedicated master nodes in the cluster"
}

variable "advanced_options" {
  type        = map(string)
  default     = {}
  description = "Key-value string pairs to specify advanced configuration options"
}

variable "elasticsearch_subdomain_name" {
  type        = string
  default     = ""
  description = "The name of the subdomain for Elasticsearch in the DNS zone (_e.g._ `elasticsearch`, `ui`, `ui-es`, `search-ui`)"
}

variable "kibana_subdomain_name" {
  type        = string
  default     = "kibana"
  description = "The name of the subdomain for Kibana in the DNS zone (_e.g._ `kibana`, `ui`, `ui-es`, `search-ui`, `kibana.elasticsearch`)"
}

variable "create_iam_service_linked_role" {
  type        = bool
  default     = true
  description = "Whether to create `AWSServiceRoleForAmazonElasticsearchService` service-linked role. Set it to `false` if you already have an ElasticSearch cluster created in the AWS account and AWSServiceRoleForAmazonElasticsearchService already exists. See https://github.com/terraform-providers/terraform-provider-aws/issues/5218 for more info"
}

variable "node_to_node_encryption_enabled" {
  type        = bool
  default     = false
  description = "Whether to enable node-to-node encryption"
}

variable "iam_role_max_session_duration" {
  type        = number
  default     = 3600
  description = "The maximum session duration (in seconds) for the user role. Can have a value from 1 hour to 12 hours"
}

variable "cognito_authentication_enabled" {
  type        = bool
  default     = false
  description = "Whether to enable Amazon Cognito authentication with Kibana"
}

variable "cognito_user_pool_id" {
  type        = string
  default     = ""
  description = "The ID of the Cognito User Pool to use"
}

variable "cognito_identity_pool_id" {
  type        = string
  default     = ""
  description = "The ID of the Cognito Identity Pool to use"
}

variable "cognito_iam_role_arn" {
  type        = string
  default     = ""
  description = "ARN of the IAM role that has the AmazonESCognitoAccess policy attached"
}
