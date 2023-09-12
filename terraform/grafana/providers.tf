terraform {
  required_providers {
    grafana = {
      source = "grafana/grafana"
      version = "2.3.0"
    }
  }
}

provider "grafana" {
  url  = "http://grafana:3000"
  auth = "${var.grafana_admin_username}:${var.grafana_admin_password}"
}