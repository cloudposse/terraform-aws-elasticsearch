variable "namespace" {
  type        = "string"
  description = "Namespace (e.g. `eg` or `cp`)"
}

variable "stage" {
  type        = "string"
  description = "Stage (e.g. `prod`, `dev`, `staging`)"
}

variable "name" {
  type        = "string"
  description = "Name of the application"
}

variable "delimiter" {
  type        = "string"
  default     = "-"
  description = "Delimiter to be used between `namespace`, `stage`, `name` and `attributes`"
}

variable "attributes" {
  type        = "list"
  default     = []
  description = "Additional attributes (e.g. `1`)"
}

variable "tags" {
  type        = "map"
  default     = {}
  description = "Additional tags (e.g. map(`BusinessUnit`,`XYZ`)"
}

variable "enabled" {
  type        = "string"
  default     = "true"
  description = "Set to false to prevent the module from creating any resources"
}

variable "security_groups" {
  type        = "list"
  default     = []
  description = "List of security group IDs to be allowed to connect to the cluster"
}

variable "allowed_cidr_blocks" {
  type        = "list"
  default     = []
  description = "List of CIDR blocks to be allowed to connect to the cluster"
}

variable "vpc_id" {
  type        = "string"
  description = "VPC ID"
}

variable "subnet_ids" {
  type        = "list"
  description = "Subnet ids"
}

variable "dns_zone_id" {
  type        = "string"
  default     = ""
  description = "Route53 DNS Zone ID to add hostname records for Elasticsearch domain and Kibana"
}

variable "elasticsearch_version" {
  type        = "string"
  default     = "6.2"
  description = "Version of Elasticsearch to deploy"
}

variable "instance_type" {
  type        = "string"
  default     = "t2.small.elasticsearch"
  description = "Elasticsearch instance type for data nodes in the cluster"
}

variable "instance_count" {
  description = "Number of data nodes in the cluster"
  default     = 4
}

variable "iam_roles" {
  type        = "list"
  default     = []
  description = "List of IAM role ARNs from which to permit management traffic"
}

variable "zone_awareness_enabled" {
  type        = "string"
  default     = "true"
  description = "Enable zone awareness for Elasticsearch cluster"
}

variable "ebs_volume_size" {
  description = "Optionally use EBS volumes for data storage by specifying volume size in GB"
  default     = 0
}

variable "ebs_volume_type" {
  type        = "string"
  default     = "gp2"
  description = "Storage type of EBS volumes"
}

variable "ebs_iops" {
  default     = 0
  description = "The baseline input/output (I/O) performance of EBS volumes attached to data nodes. Applicable only for the Provisioned IOPS EBS volume type"
}

variable "encrypt_at_rest_enabled" {
  type        = "string"
  default     = "true"
  description = "Whether to enable encryption at rest"
}

variable "encrypt_at_rest_kms_key_id" {
  type        = "string"
  default     = ""
  description = "The KMS key id to encrypt the Elasticsearch domain with. If not specified, then it defaults to using the AWS/Elasticsearch service KMS key"
}

variable "log_publishing_enabled" {
  type        = "string"
  default     = "false"
  description = "Specifies whether log publishing option is enabled or not"
}

variable "log_publishing_log_type" {
  type        = "string"
  default     = "SEARCH_SLOW_LOGS"
  description = "A type of Elasticsearch log. Valid values: INDEX_SLOW_LOGS, SEARCH_SLOW_LOGS"
}

variable "log_publishing_cloudwatch_log_group_arn" {
  type        = "string"
  default     = ""
  description = "ARN of the Cloudwatch log group to which log needs to be published"
}

variable "automated_snapshot_start_hour" {
  description = "Hour at which automated snapshots are taken, in UTC"
  default     = 0
}

variable "dedicated_master_enabled" {
  type        = "string"
  default     = "false"
  description = "Indicates whether dedicated master nodes are enabled for the cluster"
}

variable "dedicated_master_count" {
  description = "Number of dedicated master nodes in the cluster"
  default     = 0
}

variable "dedicated_master_type" {
  type        = "string"
  default     = "t2.small.elasticsearch"
  description = "Instance type of the dedicated master nodes in the cluster"
}

variable "advanced_options" {
  type        = "map"
  default     = {}
  description = "Key-value string pairs to specify advanced configuration options"
}

variable "kibana_subdomain_name" {
  type        = "string"
  default     = "kibana"
  description = "The name of the subdomain for Kibana in the DNS zone (_e.g._ `kibana`, `ui`, `ui-es`, `search-ui`, `kibana.elasticsearch`)"
}
