module "label" {
  source     = "git::https://github.com/cloudposse/terraform-null-label.git?ref=tags/0.3.7"
  enabled    = "${var.enabled}"
  namespace  = "${var.namespace}"
  name       = "${var.name}"
  stage      = "${var.stage}"
  delimiter  = "${var.delimiter}"
  attributes = "${var.attributes}"
  tags       = "${var.tags}"
}

resource "aws_security_group" "default" {
  count       = "${var.enabled == "true" ? 1 : 0}"
  vpc_id      = "${var.vpc_id}"
  name        = "${module.label.id}"
  description = "Allow inbound traffic from Security Groups and CIDRs"

  ingress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    security_groups = ["${var.security_groups}"]
  }

  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["${var.allowed_cidr_blocks}"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = "${module.label.tags}"
}

data "aws_iam_policy_document" "default" {
  statement {
    actions = [
      "es:*",
    ]

    resources = [
      "${aws_elasticsearch_domain.default.arn}",
      "${aws_elasticsearch_domain.default.arn}/*",
    ]

    principals {
      type        = "AWS"
      identifiers = ["${distinct(compact(var.iam_roles))}"]
    }
  }
}

resource "aws_elasticsearch_domain" "default" {
  count                 = "${var.enabled == "true" ? 1 : 0}"
  domain_name           = "${module.label.id}"
  elasticsearch_version = "${var.elasticsearch_version}"

  advanced_options = "${var.advanced_options}"

  ebs_options {
    ebs_enabled = "${var.ebs_volume_size > 0 ? true : false}"
    volume_size = "${var.ebs_volume_size}"
    volume_type = "${var.ebs_volume_type}"
    iops        = "${var.ebs_iops}"
  }

  encrypt_at_rest {
    enabled    = "${var.encrypt_at_rest_enabled}"
    kms_key_id = "${var.encrypt_at_rest_kms_key_id}"
  }

  cluster_config {
    instance_count           = "${var.instance_count}"
    instance_type            = "${var.instance_type}"
    dedicated_master_enabled = "${var.dedicated_master_enabled}"
    dedicated_master_count   = "${var.dedicated_master_count}"
    dedicated_master_type    = "${var.dedicated_master_type}"
    zone_awareness_enabled   = "${var.zone_awareness_enabled}"
  }

  vpc_options {
    security_group_ids = ["${aws_security_group.default.id}"]
    subnet_ids         = ["${var.subnet_ids}"]
  }

  snapshot_options {
    automated_snapshot_start_hour = "${var.automated_snapshot_start_hour}"
  }

  log_publishing_options {
    enabled                  = "${var.log_publishing_enabled }"
    log_type                 = "${var.log_publishing_log_type}"
    cloudwatch_log_group_arn = "${var.log_publishing_cloudwatch_log_group_arn}"
  }

  tags = "${module.label.tags}"
}

resource "aws_elasticsearch_domain_policy" "es_vpc_management_access" {
  count           = "${var.enabled == "true" ? 1 : 0}"
  domain_name     = "${module.label.id}"
  access_policies = "${data.aws_iam_policy_document.default.json}"
}

module "domain_hostname" {
  source    = "git::https://github.com/cloudposse/terraform-aws-route53-cluster-hostname.git?ref=tags/0.2.4"
  enabled   = "${var.enabled == "true" && length(var.dns_zone_id) > 0 ? "true" : "false"}"
  namespace = "${var.namespace}"
  stage     = "${var.stage}"
  name      = "${var.name}"
  ttl       = 60
  zone_id   = "${var.dns_zone_id}"
  records   = ["${aws_elasticsearch_domain.default.*.endpoint}"]
}

module "kibana_hostname" {
  source    = "git::https://github.com/cloudposse/terraform-aws-route53-cluster-hostname.git?ref=tags/0.2.4"
  enabled   = "${var.enabled == "true" && length(var.dns_zone_id) > 0 ? "true" : "false"}"
  namespace = "${var.namespace}"
  stage     = "${var.stage}"
  name      = "${format("kibana%s%s", var.delimiter, var.name)}"
  ttl       = 60
  zone_id   = "${var.dns_zone_id}"
  records   = ["${aws_elasticsearch_domain.default.*.kibana_endpoint}"]
}
