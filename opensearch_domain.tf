#
# Opensearch Domain 
#

resource "aws_opensearch_domain_policy" "default" {
  count           = local.opensearch_enabled && (length(var.iam_authorizing_role_arns) > 0 || length(var.iam_role_arns) > 0) ? 1 : 0
  domain_name     = length(var.elasticsearch_domain_name) > 0 ? var.elasticsearch_domain_name : module.this.id
  access_policies = join("", data.aws_iam_policy_document.default[*].json)
}

resource "aws_opensearch_domain" "default" {
  count          = local.opensearch_enabled ? 1 : 0
  domain_name    = length(var.elasticsearch_domain_name) > 0 ? var.elasticsearch_domain_name : module.this.id
  engine_version = var.elasticsearch_version

  advanced_options = var.advanced_options

  advanced_security_options {
    enabled                        = var.advanced_security_options_enabled
    internal_user_database_enabled = var.advanced_security_options_internal_user_database_enabled
    anonymous_auth_enabled         = var.advanced_security_options_anonymous_auth_enabled
    master_user_options {
      master_user_arn      = var.advanced_security_options_master_user_arn
      master_user_name     = var.advanced_security_options_master_user_name
      master_user_password = var.advanced_security_options_master_user_password
    }
  }

  dynamic "identity_center_options" {
    for_each = var.identity_center_options != null ? [var.identity_center_options] : []
    content {
      enabled_api_access           = identity_center_options.value.enabled_api_access
      identity_center_instance_arn = identity_center_options.value.identity_center_instance_arn
      subject_key                  = identity_center_options.value.subject_key
      roles_key                    = identity_center_options.value.roles_key
    }
  }

  ebs_options {
    ebs_enabled = var.ebs_volume_size > 0 ? true : false
    volume_size = var.ebs_volume_size
    volume_type = var.ebs_volume_type
    iops        = var.ebs_iops
    throughput  = var.ebs_throughput
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
    instance_count                = var.instance_count
    instance_type                 = var.instance_type
    dedicated_master_enabled      = var.dedicated_master_enabled
    dedicated_master_count        = var.dedicated_master_count
    dedicated_master_type         = var.dedicated_master_type
    multi_az_with_standby_enabled = var.multi_az_with_standby_enabled
    zone_awareness_enabled        = var.zone_awareness_enabled
    warm_enabled                  = var.warm_enabled
    warm_count                    = var.warm_enabled ? var.warm_count : null
    warm_type                     = var.warm_enabled ? var.warm_type : null

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
      security_group_ids = var.create_security_group ? [join("", aws_security_group.default[*].id)] : var.security_groups
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

  # Converted `log_publishing_options` to dynamic blocks due to the follow errors
  # │ Error: Error creating OpenSearch domain: InvalidParameter: 4 validation error(s) found.
  # │ - minimum field size of 20, CreateDomainInput.LogPublishingOptions[ES_APPLICATION_LOGS].CloudWatchLogsLogGroupArn.
  # │ - minimum field size of 20, CreateDomainInput.LogPublishingOptions[AUDIT_LOGS].CloudWatchLogsLogGroupArn.
  # │ - minimum field size of 20, CreateDomainInput.LogPublishingOptions[SEARCH_SLOW_LOGS].CloudWatchLogsLogGroupArn.
  # │ - minimum field size of 20, CreateDomainInput.LogPublishingOptions[INDEX_SLOW_LOGS].CloudWatchLogsLogGroupArn.

  dynamic "log_publishing_options" {
    for_each = var.log_publishing_index_enabled ? [true] : []
    content {
      log_type                 = "INDEX_SLOW_LOGS"
      cloudwatch_log_group_arn = var.log_publishing_index_cloudwatch_log_group_arn
    }
  }

  dynamic "log_publishing_options" {
    for_each = var.log_publishing_search_enabled ? [true] : []
    content {
      log_type                 = "SEARCH_SLOW_LOGS"
      cloudwatch_log_group_arn = var.log_publishing_search_cloudwatch_log_group_arn
    }
  }

  dynamic "log_publishing_options" {
    for_each = var.log_publishing_audit_enabled ? [true] : []
    content {
      log_type                 = "AUDIT_LOGS"
      cloudwatch_log_group_arn = var.log_publishing_audit_cloudwatch_log_group_arn
    }
  }

  dynamic "log_publishing_options" {
    for_each = var.log_publishing_application_enabled ? [true] : []
    content {
      log_type                 = "ES_APPLICATION_LOGS"
      cloudwatch_log_group_arn = var.log_publishing_application_cloudwatch_log_group_arn
    }
  }

  tags = module.this.tags

  depends_on = [aws_iam_service_linked_role.default]
}
