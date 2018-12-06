<!-- This file was automatically generated by the `build-harness`. Make all changes to `README.yaml` and run `make readme` to rebuild this file. -->

[![Cloud Posse](https://cloudposse.com/logo-300x69.svg)](https://cloudposse.com)

# terraform-aws-elasticsearch [![Build Status](https://travis-ci.org/cloudposse/terraform-aws-elasticsearch.svg?branch=master)](https://travis-ci.org/cloudposse/terraform-aws-elasticsearch) [![Latest Release](https://img.shields.io/github/release/cloudposse/terraform-aws-elasticsearch.svg)](https://github.com/cloudposse/terraform-aws-elasticsearch/releases/latest) [![Slack Community](https://slack.cloudposse.com/badge.svg)](https://slack.cloudposse.com)


Terraform module to provision an [`Elasticsearch`](https://aws.amazon.com/elasticsearch-service/) cluster with built-in integrations with [Kibana](https://aws.amazon.com/elasticsearch-service/kibana/) and [Logstash](https://aws.amazon.com/elasticsearch-service/logstash/).


---

This project is part of our comprehensive ["SweetOps"](https://docs.cloudposse.com) approach towards DevOps. 


It's 100% Open Source and licensed under the [APACHE2](LICENSE).









## Introduction

This module will create:
- Elasticsearch cluster with the specified node count in the provided subnets in a VPC
- Elasticsearch domain policy that accepts a list of IAM role ARNs from which to permit management traffic to the cluster
- Security Group to control access to the Elasticsearch domain (inputs to the Security Group are other Security Groups or CIDRs blocks to be allowed to connect to the cluster)
- DNS hostname record for Elasticsearch cluster (if DNS Zone ID is provided)
- DNS hostname record for Kibana (if DNS Zone ID is provided)

__NOTE:__ To enable [zone awareness](https://docs.aws.amazon.com/elasticsearch-service/latest/developerguide/es-managedomains.html#es-managedomains-zoneawareness) to deploy Elasticsearch nodes into two different Availability Zones, you need to set `zone_awareness_enabled` to `true` and provide two different subnets in `subnet_ids`.
If you enable zone awareness for your domain, Amazon ES places an endpoint into two subnets.
The subnets must be in different Availability Zones in the same region.
If you don't enable zone awareness, Amazon ES places an endpoint into only one subnet

## Usage

Basic [example](examples/basic)

```hcl
module "elasticsearch" {
  source                  = "git::https://github.com/cloudposse/terraform-aws-elasticsearch.git?ref=master"
  namespace               = "eg"
  stage                   = "dev"
  name                    = "es"
  dns_zone_id             = "Z14EN2YD427LRQ"
  security_groups         = ["sg-XXXXXXXXX", "sg-YYYYYYYY"]
  vpc_id                  = "vpc-XXXXXXXXX"
  subnet_ids              = ["subnet-XXXXXXXXX", "subnet-YYYYYYYY"]
  zone_awareness_enabled  = "true"
  elasticsearch_version   = "6.2"
  instance_type           = "t2.small.elasticsearch"
  instance_count          = 4
  iam_role_arns           = ["arn:aws:iam::XXXXXXXXX:role/ops", "arn:aws:iam::XXXXXXXXX:role/dev"]
  iam_actions             = ["es:ESHttpGet", "es:ESHttpPut", "es:ESHttpPost"]
  encrypt_at_rest_enabled = "true"
  kibana_subdomain_name   = "kibana-es"

  advanced_options {
    "rest.action.multi.allow_explicit_index" = "true"
  }
}
```






## Makefile Targets
```
Available targets:

  help                                Help screen
  help/all                            Display help for all targets
  help/short                          This help short screen
  lint                                Lint terraform code

```

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| advanced_options | Key-value string pairs to specify advanced configuration options | map | `<map>` | no |
| allowed_cidr_blocks | List of CIDR blocks to be allowed to connect to the cluster | list | `<list>` | no |
| attributes | Additional attributes (e.g. `1`) | list | `<list>` | no |
| automated_snapshot_start_hour | Hour at which automated snapshots are taken, in UTC | string | `0` | no |
| create_iam_service_linked_role | Whether to create `AWSServiceRoleForAmazonElasticsearchService` service-linked role. Set it to `false` if you already have an ElasticSearch cluster created in the AWS account and AWSServiceRoleForAmazonElasticsearchService already exists. See https://github.com/terraform-providers/terraform-provider-aws/issues/5218 for more info | string | `true` | no |
| dedicated_master_count | Number of dedicated master nodes in the cluster | string | `0` | no |
| dedicated_master_enabled | Indicates whether dedicated master nodes are enabled for the cluster | string | `false` | no |
| dedicated_master_type | Instance type of the dedicated master nodes in the cluster | string | `t2.small.elasticsearch` | no |
| delimiter | Delimiter to be used between `namespace`, `stage`, `name` and `attributes` | string | `-` | no |
| dns_zone_id | Route53 DNS Zone ID to add hostname records for Elasticsearch domain and Kibana | string | `` | no |
| ebs_iops | The baseline input/output (I/O) performance of EBS volumes attached to data nodes. Applicable only for the Provisioned IOPS EBS volume type | string | `0` | no |
| ebs_volume_size | Optionally use EBS volumes for data storage by specifying volume size in GB | string | `0` | no |
| ebs_volume_type | Storage type of EBS volumes | string | `gp2` | no |
| elasticsearch_version | Version of Elasticsearch to deploy | string | `6.2` | no |
| enabled | Set to false to prevent the module from creating any resources | string | `true` | no |
| encrypt_at_rest_enabled | Whether to enable encryption at rest | string | `true` | no |
| encrypt_at_rest_kms_key_id | The KMS key id to encrypt the Elasticsearch domain with. If not specified, then it defaults to using the AWS/Elasticsearch service KMS key | string | `` | no |
| iam_actions | List of actions to allow for the IAM roles, _e.g._ `es:ESHttpGet`, `es:ESHttpPut`, `es:ESHttpPost` | list | `<list>` | no |
| iam_role_arns | List of IAM role ARNs to permit access to the Elasticsearch domain | list | `<list>` | no |
| instance_count | Number of data nodes in the cluster | string | `4` | no |
| instance_type | Elasticsearch instance type for data nodes in the cluster | string | `t2.small.elasticsearch` | no |
| kibana_subdomain_name | The name of the subdomain for Kibana in the DNS zone (_e.g._ `kibana`, `ui`, `ui-es`, `search-ui`, `kibana.elasticsearch`) | string | `kibana` | no |
| log_publishing_index_cloudwatch_log_group_arn | ARN of the CloudWatch log group to which log needs to be published for INDEX_SLOW_LOGS | string | `` | no |
| log_publishing_search_cloudwatch_log_group_arn | ARN of the CloudWatch log group to which log needs to be published for SEARCH_SLOW_LOGS | string | `` | no |
| log_publishing_application_cloudwatch_log_group_arn | ARN of the CloudWatch log group to which log needs to be published for ES_APPLICATION_LOGS | string | `` | no |
| log_publishing_index_enabled | Specifies whether log publishing option for index slow logs is enabled or not | string | `false` | no |
| log_publishing_search_enabled | Specifies whether log publishing option for search slow logs is enabled or not | string | `false` | no |
| log_publishing_application_enabled | Specifies whether log publishing option for application logs is enabled or not | string | `false` | no |
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
| kibana_endpoint | Domain-specific endpoint for Kibana without https scheme |
| kibana_hostname | Kibana hostname |
| security_group_id | Security Group ID to control access to the Elasticsearch domain |





## References

For additional context, refer to some of these links. 

- [What is Amazon Elasticsearch Service](https://docs.aws.amazon.com/elasticsearch-service/latest/developerguide/what-is-amazon-elasticsearch-service.html) - Complete description of Amazon Elasticsearch Service
- [Amazon Elasticsearch Service Access Control](https://docs.aws.amazon.com/elasticsearch-service/latest/developerguide/es-ac.html) - Describes several ways of controlling access to Elasticsearch domains
- [VPC Support for Amazon Elasticsearch Service Domains](https://docs.aws.amazon.com/elasticsearch-service/latest/developerguide/es-vpc.html) - Describes Elasticsearch Service VPC Support and VPC architectures with and without zone awareness
- [Creating and Configuring Amazon Elasticsearch Service Domains](https://docs.aws.amazon.com/elasticsearch-service/latest/developerguide/es-createupdatedomains.html) - Provides a complete description on how to create and configure Amazon Elasticsearch Service (Amazon ES) domains
- [Kibana and Logstash](https://docs.aws.amazon.com/elasticsearch-service/latest/developerguide/es-kibana.html) - Describes some considerations for using Kibana and Logstash with Amazon Elasticsearch Service
- [Amazon Cognito Authentication for Kibana](https://docs.aws.amazon.com/elasticsearch-service/latest/developerguide/es-cognito-auth.html) - Amazon Elasticsearch Service uses Amazon Cognito to offer user name and password protection for Kibana
- [Control Access to Amazon Elasticsearch Service Domain](https://aws.amazon.com/blogs/security/how-to-control-access-to-your-amazon-elasticsearch-service-domain/) - Describes how to Control Access to Amazon Elasticsearch Service Domain
- [elasticsearch_domain](https://www.terraform.io/docs/providers/aws/r/elasticsearch_domain.html) - Terraform reference documentation for the `elasticsearch_domain` resource
- [elasticsearch_domain_policy](https://www.terraform.io/docs/providers/aws/r/elasticsearch_domain_policy.html) - Terraform reference documentation for the `elasticsearch_domain_policy` resource


## Help

**Got a question?**

File a GitHub [issue](https://github.com/cloudposse/terraform-aws-elasticsearch/issues), send us an [email][email] or join our [Slack Community][slack].

## Commercial Support

Work directly with our team of DevOps experts via email, slack, and video conferencing. 

We provide [*commercial support*][commercial_support] for all of our [Open Source][github] projects. As a *Dedicated Support* customer, you have access to our team of subject matter experts at a fraction of the cost of a full-time engineer. 

[![E-Mail](https://img.shields.io/badge/email-hello@cloudposse.com-blue.svg)](mailto:hello@cloudposse.com)

- **Questions.** We'll use a Shared Slack channel between your team and ours.
- **Troubleshooting.** We'll help you triage why things aren't working.
- **Code Reviews.** We'll review your Pull Requests and provide constructive feedback.
- **Bug Fixes.** We'll rapidly work to fix any bugs in our projects.
- **Build New Terraform Modules.** We'll develop original modules to provision infrastructure.
- **Cloud Architecture.** We'll assist with your cloud strategy and design.
- **Implementation.** We'll provide hands-on support to implement our reference architectures. 


## Community Forum

Get access to our [Open Source Community Forum][slack] on Slack. It's **FREE** to join for everyone! Our "SweetOps" community is where you get to talk with others who share a similar vision for how to rollout and manage infrastructure. This is the best place to talk shop, ask questions, solicit feedback, and work together as a community to build *sweet* infrastructure.

## Contributing

### Bug Reports & Feature Requests

Please use the [issue tracker](https://github.com/cloudposse/terraform-aws-elasticsearch/issues) to report any bugs or file feature requests.

### Developing

If you are interested in being a contributor and want to get involved in developing this project or [help out](https://github.com/orgs/cloudposse/projects/3) with our other projects, we would love to hear from you! Shoot us an [email](mailto:hello@cloudposse.com).

In general, PRs are welcome. We follow the typical "fork-and-pull" Git workflow.

 1. **Fork** the repo on GitHub
 2. **Clone** the project to your own machine
 3. **Commit** changes to your own branch
 4. **Push** your work back up to your fork
 5. Submit a **Pull Request** so that we can review your changes

**NOTE:** Be sure to merge the latest changes from "upstream" before making a pull request!


## Copyright

Copyright © 2017-2018 [Cloud Posse, LLC](https://cloudposse.com)



## License 

[![License](https://img.shields.io/badge/License-Apache%202.0-blue.svg)](https://opensource.org/licenses/Apache-2.0) 

See [LICENSE](LICENSE) for full details.

    Licensed to the Apache Software Foundation (ASF) under one
    or more contributor license agreements.  See the NOTICE file
    distributed with this work for additional information
    regarding copyright ownership.  The ASF licenses this file
    to you under the Apache License, Version 2.0 (the
    "License"); you may not use this file except in compliance
    with the License.  You may obtain a copy of the License at

      https://www.apache.org/licenses/LICENSE-2.0

    Unless required by applicable law or agreed to in writing,
    software distributed under the License is distributed on an
    "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
    KIND, either express or implied.  See the License for the
    specific language governing permissions and limitations
    under the License.









## Trademarks

All other trademarks referenced herein are the property of their respective owners.

## About

This project is maintained and funded by [Cloud Posse, LLC][website]. Like it? Please let us know at <hello@cloudposse.com>

[![Cloud Posse](https://cloudposse.com/logo-300x69.svg)](https://cloudposse.com)

We're a [DevOps Professional Services][hire] company based in Los Angeles, CA. We love [Open Source Software](https://github.com/cloudposse/)!

We offer paid support on all of our projects.  

Check out [our other projects][github], [apply for a job][jobs], or [hire us][hire] to help with your cloud strategy and implementation.

  [docs]: https://docs.cloudposse.com/
  [website]: https://cloudposse.com/
  [github]: https://github.com/cloudposse/
  [commercial_support]: https://github.com/orgs/cloudposse/projects
  [jobs]: https://cloudposse.com/jobs/
  [hire]: https://cloudposse.com/contact/
  [slack]: https://slack.cloudposse.com/
  [linkedin]: https://www.linkedin.com/company/cloudposse
  [twitter]: https://twitter.com/cloudposse/
  [email]: mailto:hello@cloudposse.com


### Contributors

|  [![Erik Osterman][osterman_avatar]][osterman_homepage]<br/>[Erik Osterman][osterman_homepage] | [![Andriy Knysh][aknysh_avatar]][aknysh_homepage]<br/>[Andriy Knysh][aknysh_homepage] | [![Igor Rodionov][goruha_avatar]][goruha_homepage]<br/>[Igor Rodionov][goruha_homepage] | [![Sarkis Varozian][sarkis_avatar]][sarkis_homepage]<br/>[Sarkis Varozian][sarkis_homepage] |
|---|---|---|---|

  [osterman_homepage]: https://github.com/osterman
  [osterman_avatar]: https://github.com/osterman.png?size=150
  [aknysh_homepage]: https://github.com/aknysh
  [aknysh_avatar]: https://github.com/aknysh.png?size=150
  [goruha_homepage]: https://github.com/goruha
  [goruha_avatar]: https://github.com/goruha.png?size=150
  [sarkis_homepage]: https://github.com/sarkis
  [sarkis_avatar]: https://github.com/sarkis.png?size=150


