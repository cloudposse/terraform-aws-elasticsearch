## Requirements

| Name | Version |
|------|---------|
| terraform | ~> 0.12.0 |
| aws | ~> 2.0 |
| null | ~> 2.0 |
| template | ~> 2.0 |

## Providers

| Name | Version |
|------|---------|
| aws | ~> 2.0 |
| null | ~> 2.0 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| advanced\_options | Key-value string pairs to specify advanced configuration options | `map(string)` | `{}` | no |
| allowed\_cidr\_blocks | List of CIDR blocks to be allowed to connect to the cluster | `list(string)` | `[]` | no |
| attributes | Additional attributes (e.g. `1`) | `list(string)` | `[]` | no |
| automated\_snapshot\_start\_hour | Hour at which automated snapshots are taken, in UTC | `number` | `0` | no |
| availability\_zone\_count | Number of Availability Zones for the domain to use. | `number` | `2` | no |
| cognito\_authentication\_enabled | Whether to enable Amazon Cognito authentication with Kibana | `bool` | `false` | no |
| cognito\_iam\_role\_arn | ARN of the IAM role that has the AmazonESCognitoAccess policy attached | `string` | `""` | no |
| cognito\_identity\_pool\_id | The ID of the Cognito Identity Pool to use | `string` | `""` | no |
| cognito\_user\_pool\_id | The ID of the Cognito User Pool to use | `string` | `""` | no |
| create\_iam\_service\_linked\_role | Whether to create `AWSServiceRoleForAmazonElasticsearchService` service-linked role. Set it to `false` if you already have an ElasticSearch cluster created in the AWS account and AWSServiceRoleForAmazonElasticsearchService already exists. See https://github.com/terraform-providers/terraform-provider-aws/issues/5218 for more info | `bool` | `true` | no |
| dedicated\_master\_count | Number of dedicated master nodes in the cluster | `number` | `0` | no |
| dedicated\_master\_enabled | Indicates whether dedicated master nodes are enabled for the cluster | `bool` | `false` | no |
| dedicated\_master\_type | Instance type of the dedicated master nodes in the cluster | `string` | `"t2.small.elasticsearch"` | no |
| delimiter | Delimiter to be used between `namespace`, `environment`, `stage`, `name` and `attributes` | `string` | `"-"` | no |
| dns\_zone\_id | Route53 DNS Zone ID to add hostname records for Elasticsearch domain and Kibana | `string` | `""` | no |
| domain\_endpoint\_options\_enforce\_https | Whether or not to require HTTPS | `bool` | `false` | no |
| domain\_endpoint\_options\_tls\_security\_policy | The name of the TLS security policy that needs to be applied to the HTTPS endpoint | `string` | `"Policy-Min-TLS-1-0-2019-07"` | no |
| ebs\_iops | The baseline input/output (I/O) performance of EBS volumes attached to data nodes. Applicable only for the Provisioned IOPS EBS volume type | `number` | `0` | no |
| ebs\_volume\_size | EBS volumes for data storage in GB | `number` | `0` | no |
| ebs\_volume\_type | Storage type of EBS volumes | `string` | `"gp2"` | no |
| elasticsearch\_subdomain\_name | The name of the subdomain for Elasticsearch in the DNS zone (\_e.g.\_ `elasticsearch`, `ui`, `ui-es`, `search-ui`) | `string` | `""` | no |
| elasticsearch\_version | Version of Elasticsearch to deploy (\_e.g.\_ `7.4`, `7.1`, `6.8`, `6.7`, `6.5`, `6.4`, `6.3`, `6.2`, `6.0`, `5.6`, `5.5`, `5.3`, `5.1`, `2.3`, `1.5` | `string` | `"7.4"` | no |
| enabled | Set to false to prevent the module from creating any resources | `bool` | `true` | no |
| encrypt\_at\_rest\_enabled | Whether to enable encryption at rest | `bool` | `true` | no |
| encrypt\_at\_rest\_kms\_key\_id | The KMS key ID to encrypt the Elasticsearch domain with. If not specified, then it defaults to using the AWS/Elasticsearch service KMS key | `string` | `""` | no |
| environment | Environment, e.g. 'prod', 'staging', 'dev', 'pre-prod', 'UAT' | `string` | `""` | no |
| iam\_actions | List of actions to allow for the IAM roles, _e.g._ `es:ESHttpGet`, `es:ESHttpPut`, `es:ESHttpPost` | `list(string)` | `[]` | no |
| iam\_authorizing\_role\_arns | List of IAM role ARNs to permit to assume the Elasticsearch user role | `list(string)` | `[]` | no |
| iam\_role\_arns | List of IAM role ARNs to permit access to the Elasticsearch domain | `list(string)` | `[]` | no |
| iam\_role\_max\_session\_duration | The maximum session duration (in seconds) for the user role. Can have a value from 1 hour to 12 hours | `number` | `3600` | no |
| ingress\_port\_range\_end | End number for allowed port range. (e.g. `443`) | `number` | `65535` | no |
| ingress\_port\_range\_start | Start number for allowed port range. (e.g. `443`) | `number` | `0` | no |
| instance\_count | Number of data nodes in the cluster | `number` | `4` | no |
| instance\_type | Elasticsearch instance type for data nodes in the cluster | `string` | `"t2.small.elasticsearch"` | no |
| kibana\_subdomain\_name | The name of the subdomain for Kibana in the DNS zone (\_e.g.\_ `kibana`, `ui`, `ui-es`, `search-ui`, `kibana.elasticsearch`) | `string` | `"kibana"` | no |
| label\_order | The naming order of the id output and Name tag | `list(string)` | `[]` | no |
| log\_publishing\_application\_cloudwatch\_log\_group\_arn | ARN of the CloudWatch log group to which log for ES\_APPLICATION\_LOGS needs to be published | `string` | `""` | no |
| log\_publishing\_application\_enabled | Specifies whether log publishing option for ES\_APPLICATION\_LOGS is enabled or not | `bool` | `false` | no |
| log\_publishing\_index\_cloudwatch\_log\_group\_arn | ARN of the CloudWatch log group to which log for INDEX\_SLOW\_LOGS needs to be published | `string` | `""` | no |
| log\_publishing\_index\_enabled | Specifies whether log publishing option for INDEX\_SLOW\_LOGS is enabled or not | `bool` | `false` | no |
| log\_publishing\_search\_cloudwatch\_log\_group\_arn | ARN of the CloudWatch log group to which log for SEARCH\_SLOW\_LOGS needs to be published | `string` | `""` | no |
| log\_publishing\_search\_enabled | Specifies whether log publishing option for SEARCH\_SLOW\_LOGS is enabled or not | `bool` | `false` | no |
| name | Solution name, e.g. 'app' or 'jenkins' | `string` | `""` | no |
| namespace | Namespace, which could be your organization name or abbreviation, e.g. 'eg' or 'cp' | `string` | `""` | no |
| node\_to\_node\_encryption\_enabled | Whether to enable node-to-node encryption | `bool` | `false` | no |
| security\_groups | List of security group IDs to be allowed to connect to the cluster | `list(string)` | `[]` | no |
| stage | Stage, e.g. 'prod', 'staging', 'dev', OR 'source', 'build', 'test', 'deploy', 'release' | `string` | `""` | no |
| subnet\_ids | VPC Subnet IDs | `list(string)` | `[]` | no |
| tags | Additional tags (e.g. `map('BusinessUnit','XYZ')` | `map(string)` | `{}` | no |
| vpc\_enabled | Set to false if ES should be deployed outside of VPC. | `bool` | `true` | no |
| vpc\_id | VPC ID | `string` | `null` | no |
| zone\_awareness\_enabled | Enable zone awareness for Elasticsearch cluster | `bool` | `true` | no |

## Outputs

| Name | Description |
|------|-------------|
| domain\_arn | ARN of the Elasticsearch domain |
| domain\_endpoint | Domain-specific endpoint used to submit index, search, and data upload requests |
| domain\_hostname | Elasticsearch domain hostname to submit index, search, and data upload requests |
| domain\_id | Unique identifier for the Elasticsearch domain |
| domain\_name | Name of the Elasticsearch domain |
| elasticsearch\_user\_iam\_role\_arn | The ARN of the IAM role to allow access to Elasticsearch cluster |
| elasticsearch\_user\_iam\_role\_name | The name of the IAM role to allow access to Elasticsearch cluster |
| kibana\_endpoint | Domain-specific endpoint for Kibana without https scheme |
| kibana\_hostname | Kibana hostname |
| security\_group\_id | Security Group ID to control access to the Elasticsearch domain |

