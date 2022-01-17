module "user_label" {
  source  = "cloudposse/label/null"
  version = "0.25.0"

  attributes = ["user"]

  context = module.this.context
}

module "kibana_label" {
  source  = "cloudposse/label/null"
  version = "0.25.0"

  attributes = ["kibana"]

  context = module.this.context
}

resource "aws_security_group" "default" {
  count       = module.this.enabled && var.vpc_enabled ? 1 : 0
  vpc_id      = var.vpc_id
  name        = module.this.id
  description = "Allow inbound traffic from Security Groups and CIDRs. Allow all outbound traffic"
  tags        = module.this.tags

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_security_group_rule" "ingress_security_groups" {
  count                    = module.this.enabled && var.vpc_enabled ? length(var.security_groups) : 0
  description              = "Allow inbound traffic from Security Groups"
  type                     = "ingress"
  from_port                = var.ingress_port_range_start
  to_port                  = var.ingress_port_range_end
  protocol                 = "tcp"
  source_security_group_id = var.security_groups[count.index]
  security_group_id        = join("", aws_security_group.default.*.id)
}

resource "aws_security_group_rule" "ingress_cidr_blocks" {
  count             = module.this.enabled && var.vpc_enabled && length(var.allowed_cidr_blocks) > 0 ? 1 : 0
  description       = "Allow inbound traffic from CIDR blocks"
  type              = "ingress"
  from_port         = var.ingress_port_range_start
  to_port           = var.ingress_port_range_end
  protocol          = "tcp"
  cidr_blocks       = var.allowed_cidr_blocks
  security_group_id = join("", aws_security_group.default.*.id)
}

resource "aws_security_group_rule" "egress" {
  count             = module.this.enabled && var.vpc_enabled ? 1 : 0
  description       = "Allow all egress traffic"
  type              = "egress"
  from_port         = 0
  to_port           = 65535
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = join("", aws_security_group.default.*.id)
}

# https://github.com/terraform-providers/terraform-provider-aws/issues/5218
resource "aws_iam_service_linked_role" "default" {
  count            = module.this.enabled && var.create_iam_service_linked_role ? 1 : 0
  aws_service_name = "es.amazonaws.com"
  description      = "AWSServiceRoleForAmazonElasticsearchService Service-Linked Role"
}

# Role that pods can assume for access to elasticsearch and kibana
resource "aws_iam_role" "elasticsearch_user" {
  count              = module.this.enabled && (length(var.iam_authorizing_role_arns) > 0 || length(var.iam_role_arns) > 0) ? 1 : 0
  name               = module.user_label.id
  assume_role_policy = join("", data.aws_iam_policy_document.assume_role.*.json)
  description        = "IAM Role to assume to access the Elasticsearch ${module.this.id} cluster"
  tags               = module.user_label.tags

  max_session_duration = var.iam_role_max_session_duration

  permissions_boundary = var.iam_role_permissions_boundary
}

data "aws_iam_policy_document" "assume_role" {
  count = module.this.enabled && (length(var.iam_authorizing_role_arns) > 0 || length(var.iam_role_arns) > 0) ? 1 : 0

  statement {
    actions = [
      "sts:AssumeRole"
    ]

    principals {
      type        = "Service"
      identifiers = var.aws_ec2_service_name
    }

    principals {
      type        = "AWS"
      identifiers = compact(concat(var.iam_authorizing_role_arns, var.iam_role_arns))
    }

    effect = "Allow"
  }
}

resource "aws_elasticsearch_domain" "default" {
  count                 = module.this.enabled ? 1 : 0
  domain_name           = module.this.id
  elasticsearch_version = var.elasticsearch_version

  advanced_options = var.advanced_options

  advanced_security_options {
    enabled                        = var.advanced_security_options_enabled
    internal_user_database_enabled = var.advanced_security_options_internal_user_database_enabled
    master_user_options {
      master_user_arn      = var.advanced_security_options_master_user_arn
      master_user_name     = var.advanced_security_options_master_user_name
      master_user_password = var.advanced_security_options_master_user_password
    }
  }

  ebs_options {
    ebs_enabled = var.ebs_volume_size > 0 ? true : false
    volume_size = var.ebs_volume_size
    volume_type = var.ebs_volume_type
    iops        = var.ebs_iops
  }

  encrypt_at_rest {
    enabled    = var.encrypt_at_rest_enabled
    kms_key_id = var.encrypt_at_rest_kms_key_id
  }

  domain_endpoint_options {
    enforce_https                   = var.domain_endpoint_options_enforce_https
    tls_security_policy             = var.domain_endpoint_options_tls_security_policy
    custom_endpoint_enabled         = var.custom_endpoint_enabled
    custom_endpoint                 = var.custom_endpoint_enabled ? var.custom_endpoint : null
    custom_endpoint_certificate_arn = var.custom_endpoint_enabled ? var.custom_endpoint_certificate_arn : null
  }

  cluster_config {
    instance_count           = var.instance_count
    instance_type            = var.instance_type
    dedicated_master_enabled = var.dedicated_master_enabled
    dedicated_master_count   = var.dedicated_master_count
    dedicated_master_type    = var.dedicated_master_type
    zone_awareness_enabled   = var.zone_awareness_enabled
    warm_enabled             = var.warm_enabled
    warm_count               = var.warm_enabled ? var.warm_count : null
    warm_type                = var.warm_enabled ? var.warm_type : null

    dynamic "zone_awareness_config" {
      for_each = var.availability_zone_count > 1 && var.zone_awareness_enabled ? [true] : []
      content {
        availability_zone_count = var.availability_zone_count
      }
    }
  }

  node_to_node_encryption {
    enabled = var.node_to_node_encryption_enabled
  }

  dynamic "vpc_options" {
    for_each = var.vpc_enabled ? [true] : []

    content {
      security_group_ids = [join("", aws_security_group.default.*.id)]
      subnet_ids         = var.subnet_ids
    }
  }

  snapshot_options {
    automated_snapshot_start_hour = var.automated_snapshot_start_hour
  }

  dynamic "cognito_options" {
    for_each = var.cognito_authentication_enabled ? [true] : []
    content {
      enabled          = true
      user_pool_id     = var.cognito_user_pool_id
      identity_pool_id = var.cognito_identity_pool_id
      role_arn         = var.cognito_iam_role_arn
    }
  }

  log_publishing_options {
    enabled                  = var.log_publishing_index_enabled
    log_type                 = "INDEX_SLOW_LOGS"
    cloudwatch_log_group_arn = var.log_publishing_index_cloudwatch_log_group_arn
  }

  log_publishing_options {
    enabled                  = var.log_publishing_search_enabled
    log_type                 = "SEARCH_SLOW_LOGS"
    cloudwatch_log_group_arn = var.log_publishing_search_cloudwatch_log_group_arn
  }

  log_publishing_options {
    enabled                  = var.log_publishing_audit_enabled
    log_type                 = "AUDIT_LOGS"
    cloudwatch_log_group_arn = var.log_publishing_audit_cloudwatch_log_group_arn
  }

  log_publishing_options {
    enabled                  = var.log_publishing_application_enabled
    log_type                 = "ES_APPLICATION_LOGS"
    cloudwatch_log_group_arn = var.log_publishing_application_cloudwatch_log_group_arn
  }

  tags = module.this.tags

  depends_on = [aws_iam_service_linked_role.default]
}

data "aws_iam_policy_document" "default" {
  count = module.this.enabled && (length(var.iam_authorizing_role_arns) > 0 || length(var.iam_role_arns) > 0) ? 1 : 0

  statement {
    effect = "Allow"

    actions = distinct(compact(var.iam_actions))

    resources = [
      join("", aws_elasticsearch_domain.default.*.arn),
      "${join("", aws_elasticsearch_domain.default.*.arn)}/*"
    ]

    principals {
      type        = "AWS"
      identifiers = distinct(compact(concat(var.iam_role_arns, aws_iam_role.elasticsearch_user.*.arn)))
    }
  }

  # This statement is for non VPC ES to allow anonymous access from whitelisted IP ranges without requests signing
  # https://docs.aws.amazon.com/elasticsearch-service/latest/developerguide/es-ac.html#es-ac-types-ip
  # https://aws.amazon.com/premiumsupport/knowledge-center/anonymous-not-authorized-elasticsearch/
  dynamic "statement" {
    for_each = length(var.allowed_cidr_blocks) > 0 && ! var.vpc_enabled ? [true] : []
    content {
      effect = "Allow"

      actions = distinct(compact(var.iam_actions))

      resources = [
        join("", aws_elasticsearch_domain.default.*.arn),
        "${join("", aws_elasticsearch_domain.default.*.arn)}/*"
      ]

      principals {
        type        = "AWS"
        identifiers = ["*"]
      }

      condition {
        test     = "IpAddress"
        values   = var.allowed_cidr_blocks
        variable = "aws:SourceIp"
      }
    }
  }
}

resource "aws_elasticsearch_domain_policy" "default" {
  count           = module.this.enabled && (length(var.iam_authorizing_role_arns) > 0 || length(var.iam_role_arns) > 0) ? 1 : 0
  domain_name     = module.this.id
  access_policies = join("", data.aws_iam_policy_document.default.*.json)
}

module "domain_hostname" {
  source  = "cloudposse/route53-cluster-hostname/aws"
  version = "0.12.2"

  enabled  = module.this.enabled && var.domain_hostname_enabled
  dns_name = var.elasticsearch_subdomain_name == "" ? module.this.id : var.elasticsearch_subdomain_name
  ttl      = 60
  zone_id  = var.dns_zone_id
  records  = [join("", aws_elasticsearch_domain.default.*.endpoint)]

  context = module.this.context
}

module "kibana_hostname" {
  source  = "cloudposse/route53-cluster-hostname/aws"
  version = "0.12.2"

  enabled  = module.this.enabled && var.kibana_hostname_enabled
  dns_name = var.kibana_subdomain_name == "" ? module.kibana_label.id : var.kibana_subdomain_name
  ttl      = 60
  zone_id  = var.dns_zone_id
  # Note: kibana_endpoint is not just a domain name, it includes a path component,
  # and as such is not suitable for a DNS record. The plain endpoint is the
  # hostname portion and should be used for DNS.
  records = [join("", aws_elasticsearch_domain.default.*.endpoint)]

  context = module.this.context
}
