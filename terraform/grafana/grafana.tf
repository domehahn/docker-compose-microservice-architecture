resource "grafana_dashboard" "metrics" {
  config_json = file("11378_rev2.json")
}