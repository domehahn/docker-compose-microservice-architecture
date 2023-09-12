terraform {
  required_providers {
    consul = {
      source = "hashicorp/consul"
      version = "2.17.0"
    }
  }
}

provider "consul" {
  address    = "http://consul:8500"
}