## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| advanced_options | Key-value string pairs to specify advanced configuration options | map | `<map>` | no |
| allowed_cidr_blocks | List of CIDR blocks to be allowed to connect to the cluster | list | `<list>` | no |
| attributes | Additional attributes (e.g. `1`) | list | `<list>` | no |
| automated_snapshot_start_hour | Hour at which automated snapshots are taken, in UTC | string | `0` | no |
| availability_zone_count | Number of Availability Zones for the domain to use. | string | `3` | no |
| create_iam_service_linked_role | Whether to create `AWSServiceRoleForAmazonElasticsearchService` service-linked role. Set it to `false` if you already have an ElasticSearch cluster created in the AWS account and AWSServiceRoleForAmazonElasticsearchService already exists. See https://github.com/terraform-providers/terraform-provider-aws/issues/5218 for more info | string | `true` | no |
| dedicated_master_count | Number of dedicated master nodes in the cluster | string | `0` | no |
| dedicated_master_enabled | Indicates whether dedicated master nodes are enabled for the cluster | string | `false` | no |
| dedicated_master_type | Instance type of the dedicated master nodes in the cluster | string | `t2.small.elasticsearch` | no |
| delimiter | Delimiter to be used between `namespace`, `stage`, `name` and `attributes` | string | `-` | no |
| dns_zone_id | Route53 DNS Zone ID to add hostname records for Elasticsearch domain and Kibana | string | `` | no |
| ebs_iops | The baseline input/output (I/O) performance of EBS volumes attached to data nodes. Applicable only for the Provisioned IOPS EBS volume type | string | `0` | no |
| ebs_volume_size | Optionally use EBS volumes for data storage by specifying volume size in GB | string | `0` | no |
| ebs_volume_type | Storage type of EBS volumes | string | `gp2` | no |
| elasticsearch_version | Version of Elasticsearch to deploy | string | `6.5` | no |
| enabled | Set to false to prevent the module from creating any resources | string | `true` | no |
| encrypt_at_rest_enabled | Whether to enable encryption at rest | string | `true` | no |
| encrypt_at_rest_kms_key_id | The KMS key id to encrypt the Elasticsearch domain with. If not specified, then it defaults to using the AWS/Elasticsearch service KMS key | string | `` | no |
| iam_actions | List of actions to allow for the IAM roles, _e.g._ `es:ESHttpGet`, `es:ESHttpPut`, `es:ESHttpPost` | list | `<list>` | no |
| iam_authorizing_role_arns | List of IAM role ARNs to permit to assume the Elasticsearch user role | list | `<list>` | no |
| iam_role_arns | List of IAM role ARNs to permit access to the Elasticsearch domain | list | `<list>` | no |
| instance_count | Number of data nodes in the cluster | string | `4` | no |
| instance_type | Elasticsearch instance type for data nodes in the cluster | string | `t2.small.elasticsearch` | no |
| kibana_subdomain_name | The name of the subdomain for Kibana in the DNS zone (_e.g._ `kibana`, `ui`, `ui-es`, `search-ui`, `kibana.elasticsearch`) | string | `kibana` | no |
| log_publishing_application_cloudwatch_log_group_arn | ARN of the CloudWatch log group to which log for ES_APPLICATION_LOGS needs to be published | string | `` | no |
| log_publishing_application_enabled | Specifies whether log publishing option for ES_APPLICATION_LOGS is enabled or not | string | `false` | no |
| log_publishing_index_cloudwatch_log_group_arn | ARN of the CloudWatch log group to which log for INDEX_SLOW_LOGS needs to be published | string | `` | no |
| log_publishing_index_enabled | Specifies whether log publishing option for INDEX_SLOW_LOGS is enabled or not | string | `false` | no |
| log_publishing_search_cloudwatch_log_group_arn | ARN of the CloudWatch log group to which log for SEARCH_SLOW_LOGS  needs to be published | string | `` | no |
| log_publishing_search_enabled | Specifies whether log publishing option for SEARCH_SLOW_LOGS is enabled or not | string | `false` | no |
| name | Name of the application | string | - | yes |
| namespace | Namespace (e.g. `eg` or `cp`) | string | - | yes |
| node_to_node_encryption_enabled | Whether to enable node-to-node encryption | string | `false` | no |
| security_groups | List of security group IDs to be allowed to connect to the cluster | list | `<list>` | no |
| stage | Stage (e.g. `prod`, `dev`, `staging`) | string | - | yes |
| subnet_ids | Subnet ids | list | - | yes |
| tags | Additional tags (e.g. map(`BusinessUnit`,`XYZ`) | map | `<map>` | no |
| vpc_id | VPC ID | string | - | yes |
| zone_awareness_enabled | Enable zone awareness for Elasticsearch cluster | string | `true` | no |

## Outputs

| Name | Description |
|------|-------------|
| domain_arn | ARN of the Elasticsearch domain |
| domain_endpoint | Domain-specific endpoint used to submit index, search, and data upload requests |
| domain_hostname | Elasticsearch domain hostname to submit index, search, and data upload requests |
| domain_id | Unique identifier for the Elasticsearch domain |
| elasticsearch_user_iam_role_arn | The ARN of the IAM role to allow access to Elasticsearch cluster |
| elasticsearch_user_iam_role_name | The name of the IAM role to allow access to Elasticsearch cluster |
| kibana_endpoint | Domain-specific endpoint for Kibana without https scheme |
| kibana_hostname | Kibana hostname |
| security_group_id | Security Group ID to control access to the Elasticsearch domain |

