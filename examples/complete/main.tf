provider "aws" {
  region = var.region
}

module "vpc" {
  source     = "git::https://github.com/cloudposse/terraform-aws-vpc.git?ref=tags/0.10.0"
  namespace  = var.namespace
  stage      = var.stage
  name       = var.name
  cidr_block = "172.16.0.0/16"
}

module "subnets" {
  source               = "git::https://github.com/cloudposse/terraform-aws-dynamic-subnets.git?ref=tags/0.19.0"
  availability_zones   = var.availability_zones
  namespace            = var.namespace
  stage                = var.stage
  name                 = var.name
  vpc_id               = module.vpc.vpc_id
  igw_id               = module.vpc.igw_id
  cidr_block           = module.vpc.vpc_cidr_block
  nat_gateway_enabled  = true
  nat_instance_enabled = false
}

module "elasticsearch" {
  source                         = "../../"
  namespace                      = var.namespace
  stage                          = var.stage
  name                           = var.name
  security_groups                = [module.vpc.vpc_default_security_group_id]
  vpc_id                         = module.vpc.vpc_id
  subnet_ids                     = module.subnets.private_subnet_ids
  zone_awareness_enabled         = var.zone_awareness_enabled
  elasticsearch_version          = var.elasticsearch_version
  instance_type                  = var.instance_type
  instance_count                 = var.instance_count
  encrypt_at_rest_enabled        = var.encrypt_at_rest_enabled
  dedicated_master_enabled       = var.dedicated_master_enabled
  create_iam_service_linked_role = var.create_iam_service_linked_role
  kibana_subdomain_name          = var.kibana_subdomain_name
  ebs_volume_size                = var.ebs_volume_size
  dns_zone_id                    = var.dns_zone_id

  advanced_options = {
    "rest.action.multi.allow_explicit_index" = "true"
  }
}
