provider "vault" {
  address = "http://vault:8200"
  token = "root"
}

resource "vault_kv_secret_v2" "api-gateway" {
  mount                      = "secret"
  name                       = "api-gateway"
  cas                        = 1
  delete_all_versions        = true
  data_json                  = jsonencode(
  {
    "redis.password" = "redispassword"
  }
  )
  custom_metadata {
    max_versions = 5
    data = {
      "redis.password" = "redispassword"
    }
  }
}

resource "vault_kv_secret_v2" "event-service" {
  mount                      = "secret"
  name                       = "event-service"
  cas                        = 1
  delete_all_versions        = true
  data_json                  = jsonencode(
  {
    "rabbitmq.username" = "guest",
    "rabbitmq.password" = "guest"
  }
  )
  custom_metadata {
    max_versions = 5
    data = {
      "rabbitmq.username" = "guest",
      "rabbitmq.password" = "guest"
    }
  }
}

resource "vault_kv_secret_v2" "data-service" {
  mount                      = "secret"
  name                       = "data-service"
  cas                        = 1
  delete_all_versions        = true
  data_json                  = jsonencode(
  {
    "mongodb.username" = "root",
    "mongodb.password" = "root",
    "redis.cache.password" = "eYVX7EwVmmxKPCDmwMtyKVge8oLd2t81"
  }
  )
  custom_metadata {
    max_versions = 5
    data = {
      "rabbitmq.username" = "guest",
      "rabbitmq.password" = "guest",
      "redis.cache.password" = "eYVX7EwVmmxKPCDmwMtyKVge8oLd2t81"
    }
  }
}

resource "vault_kv_secret_v2" "serverless-service" {
  mount                      = "secret"
  name                       = "serverless-service"
  cas                        = 1
  delete_all_versions        = true
  data_json                  = jsonencode(
  {
    "rabbitmq.username" = "guest",
    "rabbitmq.password" = "guest"
  }
  )
  custom_metadata {
    max_versions = 5
    data = {
      "rabbitmq.username" = "guest",
      "rabbitmq.password" = "guest"
    }
  }
}

resource "vault_kv_secret_v2" "backend-service" {
  mount                      = "secret"
  name                       = "backend-service"
  cas                        = 1
  delete_all_versions        = true
  data_json                  = jsonencode(
  {
    "rabbitmq.username" = "guest",
    "rabbitmq.password" = "guest"
  }
  )
  custom_metadata {
    max_versions = 5
    data = {
      "rabbitmq.username" = "guest",
      "rabbitmq.password" = "guest"
    }
  }
}

resource "vault_kv_secret_v2" "gitlab-ci" {
  mount                      = "secret"
  name                       = "gitlab-ci"
  cas                        = 1
  delete_all_versions        = true
  data_json                  = jsonencode(
  {
    "NPM_TOKEN" = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJyZWFsX2dyb3VwcyI6WyJyZWdpc3RyeSIsIiRhbGwiLCIkYXV0aGVudGljYXRlZCIsIkBhbGwiLCJAYXV0aGVudGljYXRlZCIsImFsbCJdLCJuYW1lIjoicmVnaXN0cnkiLCJncm91cHMiOlsicmVnaXN0cnkiLCIkYWxsIiwiJGF1dGhlbnRpY2F0ZWQiLCJAYWxsIiwiQGF1dGhlbnRpY2F0ZWQiLCJhbGwiXSwiaWF0IjoxNjg2NzY0NDg0LCJuYmYiOjE2ODY3NjQ0ODUsImV4cCI6MTY5MTk0ODQ4NH0.1--riMW8GH51wTTxxgpxeZ5C0i6TuOKIQOdzdZGB4c4",
    "NEXUS_USER" = "admin",
    "NEXUS_PASSWORD" = "admin"
  }
  )
  custom_metadata {
    max_versions = 5
    data = {
      "NPM_TOKEN" = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJyZWFsX2dyb3VwcyI6WyJyZWdpc3RyeSIsIiRhbGwiLCIkYXV0aGVudGljYXRlZCIsIkBhbGwiLCJAYXV0aGVudGljYXRlZCIsImFsbCJdLCJuYW1lIjoicmVnaXN0cnkiLCJncm91cHMiOlsicmVnaXN0cnkiLCIkYWxsIiwiJGF1dGhlbnRpY2F0ZWQiLCJAYWxsIiwiQGF1dGhlbnRpY2F0ZWQiLCJhbGwiXSwiaWF0IjoxNjg2NzY0NDg0LCJuYmYiOjE2ODY3NjQ0ODUsImV4cCI6MTY5MTk0ODQ4NH0.1--riMW8GH51wTTxxgpxeZ5C0i6TuOKIQOdzdZGB4c4",
      "NEXUS_USER" = "admin",
      "NEXUS_PASSWORD" = "admin"
    }
  }
}