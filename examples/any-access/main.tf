module "elasticsearch" {
  source                  = "../../"
  namespace               = "eg"
  stage                   = "dev"
  name                    = "es"
  create_default_iam_role = false
  iam_actions             = ["es:*"]
  vpc_id                  = "vpc-XXXXXXXXX"
  subnet_ids              = ["subnet-XXXXXXXXX", "subnet-YYYYYYYY"]
}
