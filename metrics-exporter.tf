provider "nomad" {
  address = join("", ["http://", data.aws_instances.nomad_server.private_ips[1], ":4646"])
}

data "aws_instances" "nomad_server" {

  filter {
    name   = "tag:Name"
    values = ["*nomad-server"]
  }
}

resource "nomad_job" "mysql-exporter" {
  count      = var.env == "test-sre" || var.env == "infra" ? 0 : 1
  depends_on = [module.master]
  jobspec    = templatefile("${path.module}/jobspec.hcl.tpl", {})
  hcl2 {
    enabled = true
    vars = {
      "job_name"    = join("-", ["elasticsearch-exporter", var.env])
      "datacenters" = var.datacenters
      "env" 	    = var.env
      "es_uri" 	    = module.elasticsearch.domain_endpoint
    }
  }
}
