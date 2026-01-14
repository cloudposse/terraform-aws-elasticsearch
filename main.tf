locals {
  elasticsearch_enabled = module.this.enabled && var.aws_service_type == "elasticsearch" ? true : false
  opensearch_enabled    = module.this.enabled && var.aws_service_type == "opensearch" ? true : false

  service_linked_role_name = local.elasticsearch_enabled ? "AWSServiceRoleForAmazonElasticsearchService" : "AWSServiceRoleForAmazonOpenSearchService"

  aws_service_domain_arn             = module.this.enabled ? coalesce(join("", aws_elasticsearch_domain.default[*].arn), join("", aws_opensearch_domain.default[*].arn)) : null
  aws_service_domain_endpoint        = module.this.enabled ? coalesce(join("", aws_elasticsearch_domain.default[*].endpoint), join("", aws_opensearch_domain.default[*].endpoint)) : null
  aws_service_domain_id              = module.this.enabled ? coalesce(join("", aws_elasticsearch_domain.default[*].domain_id), join("", aws_opensearch_domain.default[*].domain_id)) : null
  aws_service_domain_name            = module.this.enabled ? coalesce(join("", aws_elasticsearch_domain.default[*].domain_name), join("", aws_opensearch_domain.default[*].domain_name)) : null
  aws_service_domain_kibana_endpoint = module.this.enabled ? coalesce(join("", aws_elasticsearch_domain.default[*].kibana_endpoint), join("", aws_opensearch_domain.default[*].dashboard_endpoint)) : null
}

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
  count       = module.this.enabled && var.vpc_enabled && var.create_security_group ? 1 : 0
  vpc_id      = var.vpc_id
  name        = module.this.id
  description = "Allow inbound traffic from Security Groups and CIDRs. Allow all outbound traffic"
  tags        = module.this.tags

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_security_group_rule" "ingress_security_groups" {
  count                    = module.this.enabled && var.vpc_enabled && var.create_security_group ? length(var.security_groups) : 0
  description              = "Allow inbound traffic from Security Groups"
  type                     = "ingress"
  from_port                = var.ingress_port_range_start
  to_port                  = var.ingress_port_range_end
  protocol                 = "tcp"
  source_security_group_id = var.security_groups[count.index]
  security_group_id        = join("", aws_security_group.default[*].id)
}

resource "aws_security_group_rule" "ingress_cidr_blocks" {
  count             = module.this.enabled && var.vpc_enabled && var.create_security_group && length(var.allowed_cidr_blocks) > 0 ? 1 : 0
  description       = "Allow inbound traffic from CIDR blocks"
  type              = "ingress"
  from_port         = var.ingress_port_range_start
  to_port           = var.ingress_port_range_end
  protocol          = "tcp"
  cidr_blocks       = var.allowed_cidr_blocks
  security_group_id = join("", aws_security_group.default[*].id)
}

resource "aws_security_group_rule" "egress" {
  count             = module.this.enabled && var.vpc_enabled && var.create_security_group ? 1 : 0
  description       = "Allow all egress traffic"
  type              = "egress"
  from_port         = 0
  to_port           = 65535
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = join("", aws_security_group.default[*].id)
}

# https://github.com/terraform-providers/terraform-provider-aws/issues/5218
resource "aws_iam_service_linked_role" "default" {
  count            = module.this.enabled && var.create_iam_service_linked_role ? 1 : 0
  aws_service_name = "es.amazonaws.com"
  description      = "${local.service_linked_role_name} Service-Linked Role"
}

# Role that pods can assume for access to elasticsearch and kibana
resource "aws_iam_role" "elasticsearch_user" {
  count              = module.this.enabled && var.create_elasticsearch_user_role && (length(var.iam_authorizing_role_arns) > 0 || length(var.iam_role_arns) > 0 || var.iam_irsa_openid_connect_provider_arn != "") ? 1 : 0
  name               = module.user_label.id
  assume_role_policy = join("", data.aws_iam_policy_document.assume_role[*].json)
  description        = "IAM Role to assume to access the Elasticsearch ${module.this.id} cluster"
  tags               = module.user_label.tags

  max_session_duration = var.iam_role_max_session_duration

  permissions_boundary = var.iam_role_permissions_boundary
}

data "aws_iam_policy_document" "assume_role" {
  count = module.this.enabled && var.create_elasticsearch_user_role && (length(var.iam_authorizing_role_arns) > 0 || length(var.iam_role_arns) > 0 || var.iam_irsa_openid_connect_provider_arn != "") ? 1 : 0

  statement {
    actions = [
      "sts:AssumeRole"
    ]

    principals {
      type        = "Service"
      identifiers = var.aws_ec2_service_name
    }

    effect = "Allow"
  }

  dynamic "statement" {
    for_each = length(var.iam_authorizing_role_arns) > 0 || length(var.iam_role_arns) > 0 ? [true] : []

    content {
      effect = "Allow"

      actions = [
        "sts:AssumeRole"
      ]

      principals {
        type        = "AWS"
        identifiers = compact(concat(var.iam_authorizing_role_arns, var.iam_role_arns))
      }
    }
  }

  dynamic "statement" {
    for_each = var.iam_irsa_openid_connect_provider_arn != "" ? [true] : []
    content {
      effect = "Allow"

      actions = [
        "sts:AssumeRoleWithWebIdentity"
      ]

      principals {
        type        = "Federated"
        identifiers = [var.iam_irsa_openid_connect_provider_arn]
      }

      condition {
        test     = "StringLike"
        variable = join(":", [var.iam_irsa_openid_connect_provider_url, "sub"])
        values   = compact(concat([var.iam_irsa_service_account], var.iam_irsa_service_accounts))
      }
    }
  }
}

data "aws_iam_policy_document" "default" {
  count = module.this.enabled && (length(var.iam_authorizing_role_arns) > 0 || length(var.iam_role_arns) > 0 || var.iam_irsa_openid_connect_provider_arn != "") ? 1 : 0

  statement {
    sid = "User"

    effect = "Allow"

    actions = distinct(compact(var.iam_actions))

    resources = [
      local.aws_service_domain_arn,
      "${local.aws_service_domain_arn}/*"
    ]

    principals {
      type        = "AWS"
      identifiers = distinct(compact(concat(var.iam_role_arns, aws_iam_role.elasticsearch_user[*].arn)))
    }
  }

  # This statement is for non VPC ES to allow anonymous access from whitelisted IP ranges without requests signing
  # https://docs.aws.amazon.com/elasticsearch-service/latest/developerguide/es-ac.html#es-ac-types-ip
  # https://aws.amazon.com/premiumsupport/knowledge-center/anonymous-not-authorized-elasticsearch/
  dynamic "statement" {
    for_each = length(var.allowed_cidr_blocks) > 0 && !var.vpc_enabled ? [true] : []
    content {
      sid = "Anonymous"

      effect = "Allow"

      actions = distinct(compact(var.anonymous_iam_actions))

      resources = [
        local.aws_service_domain_arn,
        "${local.aws_service_domain_arn}/*"
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

module "domain_hostname" {
  source  = "cloudposse/route53-cluster-hostname/aws"
  version = "0.13.0"

  enabled  = module.this.enabled && var.domain_hostname_enabled
  dns_name = var.elasticsearch_subdomain_name == "" ? module.this.id : var.elasticsearch_subdomain_name
  ttl      = 60
  zone_id  = var.dns_zone_id
  records  = [local.aws_service_domain_endpoint]

  context = module.this.context
}

module "kibana_hostname" {
  source  = "cloudposse/route53-cluster-hostname/aws"
  version = "0.13.0"

  enabled  = module.this.enabled && var.kibana_hostname_enabled
  dns_name = var.kibana_subdomain_name == "" ? module.kibana_label.id : var.kibana_subdomain_name
  ttl      = 60
  zone_id  = var.dns_zone_id
  # Note: kibana_endpoint is not just a domain name, it includes a path component,
  # and as such is not suitable for a DNS record. The plain endpoint is the
  # hostname portion and should be used for DNS.
  records = [local.aws_service_domain_endpoint]

  context = module.this.context
}
