job "elasticsearch-exporter" {
  id          = var.job_name
  name        = var.job_name
  region      = "eu-central-1"
  datacenters = var.datacenters
  namespace   = var.env
  type = "service"

  update {
    stagger      = "10s"
    max_parallel = 1
    canary = 1
    auto_promote = true
    auto_revert = true
  }

  vault {
    policies      = ["sre"]
    change_mode   = "signal"
    change_signal = "SIGUSR1"
  }

  group "elasticsearch-exporter" {
    count = 1

    constraint {
      attribute = "$${attr.cpu.arch}"
      value     = "amd64"
    }

    network {
      port "http" { to = 9114 }
    }

    task "exporter" {
      driver = "docker"

      config {
        image = "ghcr.io/schuettflix/infra/elasticsearch-exporter:latest"
        ports = ["http"]
      }

      service {
        name = var.job_name
        port = "http"
        tags = [
          "metrics",
        ]

        check {
          type     = "tcp"
          interval = "5s"
          timeout  = "2s"
        }
      }

      template {
        data = <<-EOH
          ES_URI="https://${es_uri}:443"
        EOH
        destination = "local/env"
        env         = true
      }

      resources {
        cpu    = 300
        memory = 128
      }
    }
  }

}

variable "datacenters" {
  type = list(string)
}

variable "env" {
  type = string
}

variable "job_name" {
  type = string
}
