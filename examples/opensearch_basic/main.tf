provider "aws" {
  region = "us-east-2"
}

module "opensearch" {
  source                  = "../../"
  namespace               = "eg"
  stage                   = "dev"
  name                    = "es"
  dns_zone_id             = "Z14EN2YD427LRQ"
  security_groups         = ["sg-XXXXXXXXX", "sg-YYYYYYYY"]
  vpc_id                  = "vpc-XXXXXXXXX"
  subnet_ids              = ["subnet-XXXXXXXXX", "subnet-YYYYYYYY"]
  zone_awareness_enabled  = "true"
  aws_service_type        = "opensearch"
  elasticsearch_version   = "OpenSearch_3.1"
  instance_type           = "t3.small.search"
  instance_count          = 4
  ebs_volume_size         = 10
  iam_role_arns           = ["arn:aws:iam::XXXXXXXXX:role/ops", "arn:aws:iam::XXXXXXXXX:role/dev"]
  iam_actions             = ["es:ESHttpGet", "es:ESHttpPut", "es:ESHttpPost"]
  encrypt_at_rest_enabled = "true"
  kibana_subdomain_name   = "kibana-es"

  advanced_options = {
    "rest.action.multi.allow_explicit_index" = "true"
  }

  identity_center_options = {
    identity_center_instance_arn = "arn:aws:sso:::instance/ssoins-xxxxxxxxxxxxxxx"
    subject_key                  = "sub"
    roles_key                    = "roles"
    enabled_api_access           = true
  }
}
