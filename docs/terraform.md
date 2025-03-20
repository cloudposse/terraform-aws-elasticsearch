<!-- markdownlint-disable -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.3 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 5.15.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 5.15.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_domain_hostname"></a> [domain\_hostname](#module\_domain\_hostname) | cloudposse/route53-cluster-hostname/aws | 0.12.3 |
| <a name="module_kibana_hostname"></a> [kibana\_hostname](#module\_kibana\_hostname) | cloudposse/route53-cluster-hostname/aws | 0.12.3 |
| <a name="module_kibana_label"></a> [kibana\_label](#module\_kibana\_label) | cloudposse/label/null | 0.25.0 |
| <a name="module_this"></a> [this](#module\_this) | cloudposse/label/null | 0.25.0 |
| <a name="module_user_label"></a> [user\_label](#module\_user\_label) | cloudposse/label/null | 0.25.0 |

## Resources

| Name | Type |
|------|------|
| [aws_elasticsearch_domain.default](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/elasticsearch_domain) | resource |
| [aws_elasticsearch_domain_policy.default](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/elasticsearch_domain_policy) | resource |
| [aws_iam_role.elasticsearch_user](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_service_linked_role.default](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_service_linked_role) | resource |
| [aws_opensearch_domain.default](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/opensearch_domain) | resource |
| [aws_opensearch_domain_policy.default](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/opensearch_domain_policy) | resource |
| [aws_security_group.default](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [aws_security_group_rule.egress](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.ingress_cidr_blocks](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.ingress_security_groups](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_iam_policy_document.assume_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.default](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_additional_tag_map"></a> [additional\_tag\_map](#input\_additional\_tag\_map) | Additional key-value pairs to add to each map in `tags_as_list_of_maps`. Not added to `tags` or `id`.<br/>This is for some rare cases where resources want additional configuration of tags<br/>and therefore take a list of maps with tag key, value, and additional configuration. | `map(string)` | `{}` | no |
| <a name="input_advanced_options"></a> [advanced\_options](#input\_advanced\_options) | Key-value string pairs to specify advanced configuration options | `map(string)` | `{}` | no |
| <a name="input_advanced_security_options_enabled"></a> [advanced\_security\_options\_enabled](#input\_advanced\_security\_options\_enabled) | AWS Elasticsearch Kibana enchanced security plugin enabling (forces new resource) | `bool` | `false` | no |
| <a name="input_advanced_security_options_internal_user_database_enabled"></a> [advanced\_security\_options\_internal\_user\_database\_enabled](#input\_advanced\_security\_options\_internal\_user\_database\_enabled) | Whether to enable or not internal Kibana user database for ELK OpenDistro security plugin | `bool` | `false` | no |
| <a name="input_advanced_security_options_master_user_arn"></a> [advanced\_security\_options\_master\_user\_arn](#input\_advanced\_security\_options\_master\_user\_arn) | ARN of IAM user who is to be mapped to be Kibana master user (applicable if advanced\_security\_options\_internal\_user\_database\_enabled set to false) | `string` | `""` | no |
| <a name="input_advanced_security_options_master_user_name"></a> [advanced\_security\_options\_master\_user\_name](#input\_advanced\_security\_options\_master\_user\_name) | Master user username (applicable if advanced\_security\_options\_internal\_user\_database\_enabled set to true) | `string` | `""` | no |
| <a name="input_advanced_security_options_master_user_password"></a> [advanced\_security\_options\_master\_user\_password](#input\_advanced\_security\_options\_master\_user\_password) | Master user password (applicable if advanced\_security\_options\_internal\_user\_database\_enabled set to true) | `string` | `""` | no |
| <a name="input_allowed_cidr_blocks"></a> [allowed\_cidr\_blocks](#input\_allowed\_cidr\_blocks) | List of CIDR blocks to be allowed to connect to the cluster | `list(string)` | `[]` | no |
| <a name="input_anonymous_iam_actions"></a> [anonymous\_iam\_actions](#input\_anonymous\_iam\_actions) | List of actions to allow for the anonymous (`*`) IAM roles, _e.g._ `es:ESHttpGet`, `es:ESHttpPut`, `es:ESHttpPost` | `list(string)` | `[]` | no |
| <a name="input_attributes"></a> [attributes](#input\_attributes) | ID element. Additional attributes (e.g. `workers` or `cluster`) to add to `id`,<br/>in the order they appear in the list. New attributes are appended to the<br/>end of the list. The elements of the list are joined by the `delimiter`<br/>and treated as a single ID element. | `list(string)` | `[]` | no |
| <a name="input_auto_tune"></a> [auto\_tune](#input\_auto\_tune) | This object represents the auto\_tune configuration. It contains the following filed:<br/>- enabled - Whether to enable autotune.<br/>- rollback\_on\_disable - Whether to roll back to default Auto-Tune settings when disabling Auto-Tune.<br/>- starting\_time - Date and time at which to start the Auto-Tune maintenance schedule in RFC3339 format. Time should be in the future.<br/>- cron\_schedule - A cron expression specifying the recurrence pattern for an Auto-Tune maintenance schedule.<br/>- duration - Autotune maintanance window duration time in hours. | <pre>object({<br/>    enabled             = bool<br/>    rollback_on_disable = string<br/>    starting_time       = string<br/>    cron_schedule       = string<br/>    duration            = number<br/>  })</pre> | <pre>{<br/>  "cron_schedule": null,<br/>  "duration": null,<br/>  "enabled": false,<br/>  "rollback_on_disable": "NO_ROLLBACK",<br/>  "starting_time": null<br/>}</pre> | no |
| <a name="input_automated_snapshot_start_hour"></a> [automated\_snapshot\_start\_hour](#input\_automated\_snapshot\_start\_hour) | Hour at which automated snapshots are taken, in UTC | `number` | `0` | no |
| <a name="input_availability_zone_count"></a> [availability\_zone\_count](#input\_availability\_zone\_count) | Number of Availability Zones for the domain to use. | `number` | `2` | no |
| <a name="input_aws_ec2_service_name"></a> [aws\_ec2\_service\_name](#input\_aws\_ec2\_service\_name) | AWS EC2 Service Name | `list(string)` | <pre>[<br/>  "ec2.amazonaws.com"<br/>]</pre> | no |
| <a name="input_aws_service_type"></a> [aws\_service\_type](#input\_aws\_service\_type) | The type of AWS service to deploy (`elasticsearch` or `opensearch`). | `string` | `"elasticsearch"` | no |
| <a name="input_cognito_authentication_enabled"></a> [cognito\_authentication\_enabled](#input\_cognito\_authentication\_enabled) | Whether to enable Amazon Cognito authentication with Kibana | `bool` | `false` | no |
| <a name="input_cognito_iam_role_arn"></a> [cognito\_iam\_role\_arn](#input\_cognito\_iam\_role\_arn) | ARN of the IAM role that has the AmazonESCognitoAccess policy attached | `string` | `""` | no |
| <a name="input_cognito_identity_pool_id"></a> [cognito\_identity\_pool\_id](#input\_cognito\_identity\_pool\_id) | The ID of the Cognito Identity Pool to use | `string` | `""` | no |
| <a name="input_cognito_user_pool_id"></a> [cognito\_user\_pool\_id](#input\_cognito\_user\_pool\_id) | The ID of the Cognito User Pool to use | `string` | `""` | no |
| <a name="input_cold_storage_enabled"></a> [cold\_storage\_enabled](#input\_cold\_storage\_enabled) | Enables cold storage support. | `bool` | `false` | no |
| <a name="input_context"></a> [context](#input\_context) | Single object for setting entire context at once.<br/>See description of individual variables for details.<br/>Leave string and numeric variables as `null` to use default value.<br/>Individual variable settings (non-null) override settings in context object,<br/>except for attributes, tags, and additional\_tag\_map, which are merged. | `any` | <pre>{<br/>  "additional_tag_map": {},<br/>  "attributes": [],<br/>  "delimiter": null,<br/>  "descriptor_formats": {},<br/>  "enabled": true,<br/>  "environment": null,<br/>  "id_length_limit": null,<br/>  "label_key_case": null,<br/>  "label_order": [],<br/>  "label_value_case": null,<br/>  "labels_as_tags": [<br/>    "unset"<br/>  ],<br/>  "name": null,<br/>  "namespace": null,<br/>  "regex_replace_chars": null,<br/>  "stage": null,<br/>  "tags": {},<br/>  "tenant": null<br/>}</pre> | no |
| <a name="input_create_elasticsearch_user_role"></a> [create\_elasticsearch\_user\_role](#input\_create\_elasticsearch\_user\_role) | Whether to create an IAM role for Users/EC2 to assume to access the Elasticsearch domain. Set it to `false` if you already manage access through other means. | `bool` | `true` | no |
| <a name="input_create_iam_service_linked_role"></a> [create\_iam\_service\_linked\_role](#input\_create\_iam\_service\_linked\_role) | Whether to create `AWSServiceRoleForAmazonElasticsearchService` service-linked role. Set it to `false` if you already have an ElasticSearch cluster created in the AWS account and AWSServiceRoleForAmazonElasticsearchService already exists. See https://github.com/terraform-providers/terraform-provider-aws/issues/5218 for more info | `bool` | `true` | no |
| <a name="input_create_security_group"></a> [create\_security\_group](#input\_create\_security\_group) | Whether to create a dedicated security group for the Elasticsearch domain. Set it to `false` if you already have security groups that you want to attach to the domain and specify them in the `security_groups` variable. | `bool` | `true` | no |
| <a name="input_custom_endpoint"></a> [custom\_endpoint](#input\_custom\_endpoint) | Fully qualified domain for custom endpoint. | `string` | `""` | no |
| <a name="input_custom_endpoint_certificate_arn"></a> [custom\_endpoint\_certificate\_arn](#input\_custom\_endpoint\_certificate\_arn) | ACM certificate ARN for custom endpoint. | `string` | `""` | no |
| <a name="input_custom_endpoint_enabled"></a> [custom\_endpoint\_enabled](#input\_custom\_endpoint\_enabled) | Whether to enable custom endpoint for the Elasticsearch domain. | `bool` | `false` | no |
| <a name="input_dedicated_master_count"></a> [dedicated\_master\_count](#input\_dedicated\_master\_count) | Number of dedicated master nodes in the cluster | `number` | `0` | no |
| <a name="input_dedicated_master_enabled"></a> [dedicated\_master\_enabled](#input\_dedicated\_master\_enabled) | Indicates whether dedicated master nodes are enabled for the cluster | `bool` | `false` | no |
| <a name="input_dedicated_master_type"></a> [dedicated\_master\_type](#input\_dedicated\_master\_type) | Instance type of the dedicated master nodes in the cluster | `string` | `"t2.small.elasticsearch"` | no |
| <a name="input_delimiter"></a> [delimiter](#input\_delimiter) | Delimiter to be used between ID elements.<br/>Defaults to `-` (hyphen). Set to `""` to use no delimiter at all. | `string` | `null` | no |
| <a name="input_descriptor_formats"></a> [descriptor\_formats](#input\_descriptor\_formats) | Describe additional descriptors to be output in the `descriptors` output map.<br/>Map of maps. Keys are names of descriptors. Values are maps of the form<br/>`{<br/>   format = string<br/>   labels = list(string)<br/>}`<br/>(Type is `any` so the map values can later be enhanced to provide additional options.)<br/>`format` is a Terraform format string to be passed to the `format()` function.<br/>`labels` is a list of labels, in order, to pass to `format()` function.<br/>Label values will be normalized before being passed to `format()` so they will be<br/>identical to how they appear in `id`.<br/>Default is `{}` (`descriptors` output will be empty). | `any` | `{}` | no |
| <a name="input_dns_zone_id"></a> [dns\_zone\_id](#input\_dns\_zone\_id) | Route53 DNS Zone ID to add hostname records for Elasticsearch domain and Kibana | `string` | `""` | no |
| <a name="input_domain_endpoint_options_enforce_https"></a> [domain\_endpoint\_options\_enforce\_https](#input\_domain\_endpoint\_options\_enforce\_https) | Whether or not to require HTTPS | `bool` | `true` | no |
| <a name="input_domain_endpoint_options_tls_security_policy"></a> [domain\_endpoint\_options\_tls\_security\_policy](#input\_domain\_endpoint\_options\_tls\_security\_policy) | The name of the TLS security policy that needs to be applied to the HTTPS endpoint | `string` | `"Policy-Min-TLS-1-0-2019-07"` | no |
| <a name="input_domain_hostname_enabled"></a> [domain\_hostname\_enabled](#input\_domain\_hostname\_enabled) | Explicit flag to enable creating a DNS hostname for ES. If `true`, then `var.dns_zone_id` is required. | `bool` | `false` | no |
| <a name="input_ebs_iops"></a> [ebs\_iops](#input\_ebs\_iops) | The baseline input/output (I/O) performance of EBS volumes attached to data nodes. Applicable only for the Provisioned IOPS EBS volume type | `number` | `0` | no |
| <a name="input_ebs_throughput"></a> [ebs\_throughput](#input\_ebs\_throughput) | Specifies the throughput (in MiB/s) of the EBS volumes attached to data nodes. Applicable only for the gp3 volume type. Valid values are between 125 and 1000. | `number` | `null` | no |
| <a name="input_ebs_volume_size"></a> [ebs\_volume\_size](#input\_ebs\_volume\_size) | EBS volumes for data storage in GB | `number` | `0` | no |
| <a name="input_ebs_volume_type"></a> [ebs\_volume\_type](#input\_ebs\_volume\_type) | Storage type of EBS volumes | `string` | `"gp2"` | no |
| <a name="input_elasticsearch_subdomain_name"></a> [elasticsearch\_subdomain\_name](#input\_elasticsearch\_subdomain\_name) | The name of the subdomain for Elasticsearch in the DNS zone (\_e.g.\_ `elasticsearch`, `ui`, `ui-es`, `search-ui`) | `string` | `""` | no |
| <a name="input_elasticsearch_version"></a> [elasticsearch\_version](#input\_elasticsearch\_version) | Version of Elasticsearch to deploy (\_e.g.\_ `7.4`, `7.1`, `6.8`, `6.7`, `6.5`, `6.4`, `6.3`, `6.2`, `6.0`, `5.6`, `5.5`, `5.3`, `5.1`, `2.3`, `1.5` | `string` | `"7.4"` | no |
| <a name="input_enabled"></a> [enabled](#input\_enabled) | Set to false to prevent the module from creating any resources | `bool` | `null` | no |
| <a name="input_encrypt_at_rest_enabled"></a> [encrypt\_at\_rest\_enabled](#input\_encrypt\_at\_rest\_enabled) | Whether to enable encryption at rest | `bool` | `true` | no |
| <a name="input_encrypt_at_rest_kms_key_id"></a> [encrypt\_at\_rest\_kms\_key\_id](#input\_encrypt\_at\_rest\_kms\_key\_id) | The KMS key ID to encrypt the Elasticsearch domain with. If not specified, then it defaults to using the AWS/Elasticsearch service KMS key | `string` | `""` | no |
| <a name="input_environment"></a> [environment](#input\_environment) | ID element. Usually used for region e.g. 'uw2', 'us-west-2', OR role 'prod', 'staging', 'dev', 'UAT' | `string` | `null` | no |
| <a name="input_iam_actions"></a> [iam\_actions](#input\_iam\_actions) | List of actions to allow for the user IAM roles, _e.g._ `es:ESHttpGet`, `es:ESHttpPut`, `es:ESHttpPost` | `list(string)` | `[]` | no |
| <a name="input_iam_authorizing_role_arns"></a> [iam\_authorizing\_role\_arns](#input\_iam\_authorizing\_role\_arns) | List of IAM role ARNs to permit to assume the Elasticsearch user role | `list(string)` | `[]` | no |
| <a name="input_iam_role_arns"></a> [iam\_role\_arns](#input\_iam\_role\_arns) | List of IAM role ARNs to permit access to the Elasticsearch domain | `list(string)` | `[]` | no |
| <a name="input_iam_role_max_session_duration"></a> [iam\_role\_max\_session\_duration](#input\_iam\_role\_max\_session\_duration) | The maximum session duration (in seconds) for the user role. Can have a value from 1 hour to 12 hours | `number` | `3600` | no |
| <a name="input_iam_role_permissions_boundary"></a> [iam\_role\_permissions\_boundary](#input\_iam\_role\_permissions\_boundary) | The ARN of the permissions boundary policy which will be attached to the Elasticsearch user role | `string` | `null` | no |
| <a name="input_id_length_limit"></a> [id\_length\_limit](#input\_id\_length\_limit) | Limit `id` to this many characters (minimum 6).<br/>Set to `0` for unlimited length.<br/>Set to `null` for keep the existing setting, which defaults to `0`.<br/>Does not affect `id_full`. | `number` | `null` | no |
| <a name="input_ingress_port_range_end"></a> [ingress\_port\_range\_end](#input\_ingress\_port\_range\_end) | End number for allowed port range. (e.g. `443`) | `number` | `65535` | no |
| <a name="input_ingress_port_range_start"></a> [ingress\_port\_range\_start](#input\_ingress\_port\_range\_start) | Start number for allowed port range. (e.g. `443`) | `number` | `0` | no |
| <a name="input_instance_count"></a> [instance\_count](#input\_instance\_count) | Number of data nodes in the cluster | `number` | `4` | no |
| <a name="input_instance_type"></a> [instance\_type](#input\_instance\_type) | Elasticsearch instance type for data nodes in the cluster | `string` | `"t2.small.elasticsearch"` | no |
| <a name="input_kibana_hostname_enabled"></a> [kibana\_hostname\_enabled](#input\_kibana\_hostname\_enabled) | Explicit flag to enable creating a DNS hostname for Kibana. If `true`, then `var.dns_zone_id` is required. | `bool` | `false` | no |
| <a name="input_kibana_subdomain_name"></a> [kibana\_subdomain\_name](#input\_kibana\_subdomain\_name) | The name of the subdomain for Kibana in the DNS zone (\_e.g.\_ `kibana`, `ui`, `ui-es`, `search-ui`, `kibana.elasticsearch`) | `string` | `""` | no |
| <a name="input_label_key_case"></a> [label\_key\_case](#input\_label\_key\_case) | Controls the letter case of the `tags` keys (label names) for tags generated by this module.<br/>Does not affect keys of tags passed in via the `tags` input.<br/>Possible values: `lower`, `title`, `upper`.<br/>Default value: `title`. | `string` | `null` | no |
| <a name="input_label_order"></a> [label\_order](#input\_label\_order) | The order in which the labels (ID elements) appear in the `id`.<br/>Defaults to ["namespace", "environment", "stage", "name", "attributes"].<br/>You can omit any of the 6 labels ("tenant" is the 6th), but at least one must be present. | `list(string)` | `null` | no |
| <a name="input_label_value_case"></a> [label\_value\_case](#input\_label\_value\_case) | Controls the letter case of ID elements (labels) as included in `id`,<br/>set as tag values, and output by this module individually.<br/>Does not affect values of tags passed in via the `tags` input.<br/>Possible values: `lower`, `title`, `upper` and `none` (no transformation).<br/>Set this to `title` and set `delimiter` to `""` to yield Pascal Case IDs.<br/>Default value: `lower`. | `string` | `null` | no |
| <a name="input_labels_as_tags"></a> [labels\_as\_tags](#input\_labels\_as\_tags) | Set of labels (ID elements) to include as tags in the `tags` output.<br/>Default is to include all labels.<br/>Tags with empty values will not be included in the `tags` output.<br/>Set to `[]` to suppress all generated tags.<br/>**Notes:**<br/>  The value of the `name` tag, if included, will be the `id`, not the `name`.<br/>  Unlike other `null-label` inputs, the initial setting of `labels_as_tags` cannot be<br/>  changed in later chained modules. Attempts to change it will be silently ignored. | `set(string)` | <pre>[<br/>  "default"<br/>]</pre> | no |
| <a name="input_log_publishing_application_cloudwatch_log_group_arn"></a> [log\_publishing\_application\_cloudwatch\_log\_group\_arn](#input\_log\_publishing\_application\_cloudwatch\_log\_group\_arn) | ARN of the CloudWatch log group to which log for ES\_APPLICATION\_LOGS needs to be published | `string` | `""` | no |
| <a name="input_log_publishing_application_enabled"></a> [log\_publishing\_application\_enabled](#input\_log\_publishing\_application\_enabled) | Specifies whether log publishing option for ES\_APPLICATION\_LOGS is enabled or not | `bool` | `false` | no |
| <a name="input_log_publishing_audit_cloudwatch_log_group_arn"></a> [log\_publishing\_audit\_cloudwatch\_log\_group\_arn](#input\_log\_publishing\_audit\_cloudwatch\_log\_group\_arn) | ARN of the CloudWatch log group to which log for AUDIT\_LOGS needs to be published | `string` | `""` | no |
| <a name="input_log_publishing_audit_enabled"></a> [log\_publishing\_audit\_enabled](#input\_log\_publishing\_audit\_enabled) | Specifies whether log publishing option for AUDIT\_LOGS is enabled or not | `bool` | `false` | no |
| <a name="input_log_publishing_index_cloudwatch_log_group_arn"></a> [log\_publishing\_index\_cloudwatch\_log\_group\_arn](#input\_log\_publishing\_index\_cloudwatch\_log\_group\_arn) | ARN of the CloudWatch log group to which log for INDEX\_SLOW\_LOGS needs to be published | `string` | `""` | no |
| <a name="input_log_publishing_index_enabled"></a> [log\_publishing\_index\_enabled](#input\_log\_publishing\_index\_enabled) | Specifies whether log publishing option for INDEX\_SLOW\_LOGS is enabled or not | `bool` | `false` | no |
| <a name="input_log_publishing_search_cloudwatch_log_group_arn"></a> [log\_publishing\_search\_cloudwatch\_log\_group\_arn](#input\_log\_publishing\_search\_cloudwatch\_log\_group\_arn) | ARN of the CloudWatch log group to which log for SEARCH\_SLOW\_LOGS needs to be published | `string` | `""` | no |
| <a name="input_log_publishing_search_enabled"></a> [log\_publishing\_search\_enabled](#input\_log\_publishing\_search\_enabled) | Specifies whether log publishing option for SEARCH\_SLOW\_LOGS is enabled or not | `bool` | `false` | no |
| <a name="input_multi_az_with_standby_enabled"></a> [multi\_az\_with\_standby\_enabled](#input\_multi\_az\_with\_standby\_enabled) | Enable domain with standby for OpenSearch cluster | `bool` | `false` | no |
| <a name="input_name"></a> [name](#input\_name) | ID element. Usually the component or solution name, e.g. 'app' or 'jenkins'.<br/>This is the only ID element not also included as a `tag`.<br/>The "name" tag is set to the full `id` string. There is no tag with the value of the `name` input. | `string` | `null` | no |
| <a name="input_namespace"></a> [namespace](#input\_namespace) | ID element. Usually an abbreviation of your organization name, e.g. 'eg' or 'cp', to help ensure generated IDs are globally unique | `string` | `null` | no |
| <a name="input_node_to_node_encryption_enabled"></a> [node\_to\_node\_encryption\_enabled](#input\_node\_to\_node\_encryption\_enabled) | Whether to enable node-to-node encryption | `bool` | `false` | no |
| <a name="input_regex_replace_chars"></a> [regex\_replace\_chars](#input\_regex\_replace\_chars) | Terraform regular expression (regex) string.<br/>Characters matching the regex will be removed from the ID elements.<br/>If not set, `"/[^a-zA-Z0-9-]/"` is used to remove all characters other than hyphens, letters and digits. | `string` | `null` | no |
| <a name="input_security_groups"></a> [security\_groups](#input\_security\_groups) | List of security group IDs to be allowed to connect to the cluster or the security group IDs to apply to the cluster when the `create_security_group` variable is set to false. | `list(string)` | `[]` | no |
| <a name="input_stage"></a> [stage](#input\_stage) | ID element. Usually used to indicate role, e.g. 'prod', 'staging', 'source', 'build', 'test', 'deploy', 'release' | `string` | `null` | no |
| <a name="input_subnet_ids"></a> [subnet\_ids](#input\_subnet\_ids) | VPC Subnet IDs | `list(string)` | `[]` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Additional tags (e.g. `{'BusinessUnit': 'XYZ'}`).<br/>Neither the tag keys nor the tag values will be modified by this module. | `map(string)` | `{}` | no |
| <a name="input_tenant"></a> [tenant](#input\_tenant) | ID element \_(Rarely used, not included by default)\_. A customer identifier, indicating who this instance of a resource is for | `string` | `null` | no |
| <a name="input_vpc_enabled"></a> [vpc\_enabled](#input\_vpc\_enabled) | Set to false if ES should be deployed outside of VPC. | `bool` | `true` | no |
| <a name="input_vpc_id"></a> [vpc\_id](#input\_vpc\_id) | VPC ID | `string` | `null` | no |
| <a name="input_warm_count"></a> [warm\_count](#input\_warm\_count) | Number of UltraWarm nodes | `number` | `2` | no |
| <a name="input_warm_enabled"></a> [warm\_enabled](#input\_warm\_enabled) | Whether AWS UltraWarm is enabled | `bool` | `false` | no |
| <a name="input_warm_type"></a> [warm\_type](#input\_warm\_type) | Type of UltraWarm nodes | `string` | `"ultrawarm1.medium.elasticsearch"` | no |
| <a name="input_zone_awareness_enabled"></a> [zone\_awareness\_enabled](#input\_zone\_awareness\_enabled) | Enable zone awareness for Elasticsearch cluster | `bool` | `true` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_domain_arn"></a> [domain\_arn](#output\_domain\_arn) | ARN of the Elasticsearch domain |
| <a name="output_domain_endpoint"></a> [domain\_endpoint](#output\_domain\_endpoint) | Domain-specific endpoint used to submit index, search, and data upload requests |
| <a name="output_domain_hostname"></a> [domain\_hostname](#output\_domain\_hostname) | Elasticsearch domain hostname to submit index, search, and data upload requests |
| <a name="output_domain_id"></a> [domain\_id](#output\_domain\_id) | Unique identifier for the Elasticsearch domain |
| <a name="output_domain_name"></a> [domain\_name](#output\_domain\_name) | Name of the Elasticsearch domain |
| <a name="output_elasticsearch_user_iam_role_arn"></a> [elasticsearch\_user\_iam\_role\_arn](#output\_elasticsearch\_user\_iam\_role\_arn) | The ARN of the IAM role to allow access to Elasticsearch cluster |
| <a name="output_elasticsearch_user_iam_role_name"></a> [elasticsearch\_user\_iam\_role\_name](#output\_elasticsearch\_user\_iam\_role\_name) | The name of the IAM role to allow access to Elasticsearch cluster |
| <a name="output_kibana_endpoint"></a> [kibana\_endpoint](#output\_kibana\_endpoint) | Domain-specific endpoint for Kibana without https scheme |
| <a name="output_kibana_hostname"></a> [kibana\_hostname](#output\_kibana\_hostname) | Kibana hostname |
| <a name="output_security_group_id"></a> [security\_group\_id](#output\_security\_group\_id) | Security Group ID to control access to the Elasticsearch domain |
<!-- markdownlint-restore -->
