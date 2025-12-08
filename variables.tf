variable "security_groups" {
  type        = list(string)
  default     = []
  description = "List of security group IDs to be allowed to connect to the cluster or the security group IDs to apply to the cluster when the `create_security_group` variable is set to false."
}

variable "create_security_group" {
  type        = bool
  default     = true
  description = "Whether to create a dedicated security group for the Elasticsearch domain. Set it to `false` if you already have security groups that you want to attach to the domain and specify them in the `security_groups` variable."
}

variable "create_elasticsearch_user_role" {
  type        = bool
  default     = true
  description = "Whether to create an IAM role for Users/EC2 to assume to access the Elasticsearch domain. Set it to `false` if you already manage access through other means."
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
  default     = "7.10"
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

variable "warm_enabled" {
  type        = bool
  default     = false
  description = "Whether AWS UltraWarm is enabled"
}

variable "warm_count" {
  type        = number
  default     = 2
  description = "Number of UltraWarm nodes"
}

variable "warm_type" {
  type        = string
  default     = "ultrawarm1.medium.elasticsearch"
  description = "Type of UltraWarm nodes"
}

variable "iam_role_arns" {
  type        = list(string)
  default     = []
  description = "List of IAM role ARNs to permit access to the Elasticsearch domain"
}

variable "iam_role_permissions_boundary" {
  type        = string
  default     = null
  description = "The ARN of the permissions boundary policy which will be attached to the Elasticsearch user role"
}

variable "iam_authorizing_role_arns" {
  type        = list(string)
  default     = []
  description = "List of IAM role ARNs to permit to assume the Elasticsearch user role"
}

variable "iam_actions" {
  type        = list(string)
  default     = []
  description = "List of actions to allow for the user IAM roles, _e.g._ `es:ESHttpGet`, `es:ESHttpPut`, `es:ESHttpPost`"
}

variable "anonymous_iam_actions" {
  type        = list(string)
  default     = []
  description = "List of actions to allow for the anonymous (`*`) IAM roles, _e.g._ `es:ESHttpGet`, `es:ESHttpPut`, `es:ESHttpPost`"
}

variable "iam_irsa_openid_connect_provider_arn" {
  type        = string
  default     = ""
  description = "ARN of the OpenID connect provider to allow usage of IRSA"
}

variable "iam_irsa_openid_connect_provider_url" {
  type        = string
  default     = ""
  description = "URL of the OpenID connect provider to allow usage of IRSA"
}

variable "iam_irsa_service_account" {
  type        = string
  default     = "system:serviceaccount:default:*"
  description = "Kubernetes ServiceAccount to allow to access the Elastic Domain via IRSA"
}

variable "iam_irsa_service_accounts" {
  type        = list(string)
  default     = []
  description = "Kubernetes ServiceAccounts to allow to access the Elastic Domain via IRSA"
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

  validation {
    condition     = contains([2, 3], var.availability_zone_count)
    error_message = "The availability zone count must be 2 or 3."
  }
}

variable "multi_az_with_standby_enabled" {
  type        = bool
  default     = false
  description = "Enable domain with standby for OpenSearch cluster"
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

variable "ebs_throughput" {
  type        = number
  default     = null
  description = "Specifies the throughput (in MiB/s) of the EBS volumes attached to data nodes. Applicable only for the gp3 volume type. Valid values are between 125 and 1000."
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
  default     = true
  description = "Whether or not to require HTTPS"
}

variable "domain_endpoint_options_tls_security_policy" {
  type        = string
  default     = "Policy-Min-TLS-1-2-2019-07"
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

variable "log_publishing_audit_enabled" {
  type        = bool
  default     = false
  description = "Specifies whether log publishing option for AUDIT_LOGS is enabled or not"
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

variable "log_publishing_audit_cloudwatch_log_group_arn" {
  type        = string
  default     = ""
  description = "ARN of the CloudWatch log group to which log for AUDIT_LOGS needs to be published"
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

variable "elasticsearch_domain_name" {
  type        = string
  default     = ""
  description = "The name of the Elasticsearch domain. Must be at least 3 and no more than 28 characters long. Valid characters are a-z (lowercase letters), 0-9, and - (hyphen)."

  validation {
    condition     = var.elasticsearch_domain_name == "" || (length(var.elasticsearch_domain_name) >= 3 && length(var.elasticsearch_domain_name) <= 28)
    error_message = "The elasticsearch_domain_name must meet following conditions: 1) be empty string or 2) must start with a lowercase alphabet and be at least 3 and no more than 28 characters long. Valid characters are a-z (lowercase letters), 0-9, and - (hyphen)."
  }

  validation {
    condition     = var.elasticsearch_domain_name == "" || can(regex("^[a-z][a-z0-9-]*$", var.elasticsearch_domain_name))
    error_message = "The elasticsearch_domain_name must meet following conditions: 1) be empty string or 2) must start with a lowercase alphabet and be at least 3 and no more than 28 characters long. Valid characters are a-z (lowercase letters), 0-9, and - (hyphen)."
  }
}

variable "elasticsearch_subdomain_name" {
  type        = string
  default     = ""
  description = "The name of the subdomain for Elasticsearch in the DNS zone (_e.g._ `elasticsearch`, `ui`, `ui-es`, `search-ui`)"
}

variable "kibana_subdomain_name" {
  type        = string
  default     = ""
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

variable "aws_ec2_service_name" {
  type        = list(string)
  default     = ["ec2.amazonaws.com"]
  description = "AWS EC2 Service Name"
}

variable "domain_hostname_enabled" {
  type        = bool
  description = "Explicit flag to enable creating a DNS hostname for ES. If `true`, then `var.dns_zone_id` is required."
  default     = false
}

variable "kibana_hostname_enabled" {
  type        = bool
  description = "Explicit flag to enable creating a DNS hostname for Kibana. If `true`, then `var.dns_zone_id` is required."
  default     = false
}

variable "advanced_security_options_enabled" {
  type        = bool
  default     = false
  description = "AWS Elasticsearch Kibana enchanced security plugin enabling (forces new resource)"
}

variable "advanced_security_options_internal_user_database_enabled" {
  type        = bool
  default     = false
  description = "Whether to enable or not internal Kibana user database for ELK OpenDistro security plugin"
}

variable "advanced_security_options_master_user_arn" {
  type        = string
  default     = ""
  description = "ARN of IAM user who is to be mapped to be Kibana master user (applicable if advanced_security_options_internal_user_database_enabled set to false)"
}

variable "advanced_security_options_master_user_name" {
  type        = string
  default     = ""
  description = "Master user username (applicable if advanced_security_options_internal_user_database_enabled set to true)"
}

variable "advanced_security_options_master_user_password" {
  type        = string
  default     = ""
  description = "Master user password (applicable if advanced_security_options_internal_user_database_enabled set to true)"
}

variable "custom_endpoint_enabled" {
  type        = bool
  description = "Whether to enable custom endpoint for the Elasticsearch domain."
  default     = false
}

variable "custom_endpoint" {
  type        = string
  description = "Fully qualified domain for custom endpoint."
  default     = ""
}

variable "custom_endpoint_certificate_arn" {
  type        = string
  description = "ACM certificate ARN for custom endpoint."
  default     = ""
}

variable "aws_service_type" {
  type        = string
  description = "The type of AWS service to deploy (`elasticsearch` or `opensearch`)."
  # For backwards comptibility we default to elasticsearch
  default = "elasticsearch"

  validation {
    condition     = contains(["elasticsearch", "opensearch"], var.aws_service_type)
    error_message = "Value can only be one of `elasticsearch` or `opensearch`."
  }
}

variable "cold_storage_enabled" {
  type        = bool
  description = "Enables cold storage support."
  default     = false
}

variable "auto_tune" {
  type = object({
    enabled             = bool
    rollback_on_disable = string
    starting_time       = string
    cron_schedule       = string
    duration            = number
  })

  default = {
    enabled             = false
    rollback_on_disable = "NO_ROLLBACK"
    starting_time       = null
    cron_schedule       = null
    duration            = null
  }

  description = <<-EOT
    This object represents the auto_tune configuration. It contains the following filed:
    - enabled - Whether to enable autotune.
    - rollback_on_disable - Whether to roll back to default Auto-Tune settings when disabling Auto-Tune.
    - starting_time - Date and time at which to start the Auto-Tune maintenance schedule in RFC3339 format. Time should be in the future.
    - cron_schedule - A cron expression specifying the recurrence pattern for an Auto-Tune maintenance schedule.
    - duration - Autotune maintanance window duration time in hours.
  EOT

  validation {
    condition     = var.auto_tune.enabled == false || var.auto_tune.cron_schedule != null
    error_message = "Variable auto_tune.cron_schedule should be set if var.auto_tune.enabled == true."
  }

  validation {
    condition     = var.auto_tune.enabled == false || var.auto_tune.duration != null
    error_message = "Variable auto_tune.duration should be set if var.auto_tune.enabled == true."
  }

  validation {
    condition     = contains(["DEFAULT_ROLLBACK", "NO_ROLLBACK"], var.auto_tune.rollback_on_disable)
    error_message = "Variable auto_tune.rollback_on_disable valid values: DEFAULT_ROLLBACK or NO_ROLLBACK."
  }
}

variable "advanced_security_options_anonymous_auth_enabled" {
  type        = bool
  default     = false
  description = "Whether Anonymous auth is enabled. Enables fine-grained access control on an existing domain"
}

variable "identity_center_options" {
  type = object({
    enabled_api_access           = optional(bool, true)
    identity_center_instance_arn = string
    subject_key                  = string
    roles_key                    = string
  })

  default     = null
  description = "Configuration block for authenticating AWS IAM Identity Center principals via OpenSearch identity_center_options. Applicable to aws_opensearch_domain only."
}

variable "access_policies" {
  description = "JSON string for the IAM policy document specifying the access policies for the domain."
  type        = string
  default     = ""
  validation {
    condition     = var.access_policies == "" || try(jsondecode(var.access_policies), null) != null
    error_message = "The access_policies JSON string is not valid."
  }
}
