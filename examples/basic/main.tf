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
  iam_roles               = ["arn:aws:iam::XXXXXXXXX:role/ops", "arn:aws:iam::XXXXXXXXX:role/dev"]
  encrypt_at_rest_enabled = "true"
  kibana_subdomain_name   = "kibana-es"

  advanced_options {
    "rest.action.multi.allow_explicit_index" = "true"
  }
}
