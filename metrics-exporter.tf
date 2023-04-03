provider "nomad" {
  address = join("", ["http://", data.aws_instances.nomad_server.private_ips[1], ":4646"])
}

data "aws_instances" "nomad_server" {

  filter {
    name   = "tag:Name"
    values = ["*nomad-server"]
  }
}

resource "nomad_job" "elasticsearch-exporter" {
  count      = var.env == "test-sre" || var.env == "infra" ? 0 : 1
  jobspec    = templatefile("${path.module}/jobspec.hcl.tpl", {
    #es_uri = module.domain_hostname.hostname
    es_uri = join("", aws_opensearch_domain.default.*.endpoint)
  })
  hcl2 {
    enabled = true
    vars = {
      "job_name"    = join("-", ["elasticsearch-exporter", var.env])
      "datacenters" = var.datacenters
      "env" 	    = var.env
    }
  }
}
