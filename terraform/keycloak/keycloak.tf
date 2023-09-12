locals {
  microservice_realm_id  = "microservice"
  microservice_client_id = "api-gateway"
}

#create realm
resource "keycloak_realm" "microservice_realm" {
  realm       = local.microservice_realm_id
  enabled     = true
  display_name = local.microservice_realm_id
}

# create grafana openid client
resource "keycloak_openid_client" "microservice_client" {
  realm_id                      = keycloak_realm.microservice_realm.id
  client_id                     = local.microservice_client_id
  name                          = local.microservice_client_id
  enabled                       = true
  access_type                   = "CONFIDENTIAL"
  client_secret                 = "microservice-client-secret"
  service_accounts_enabled      = true
  direct_access_grants_enabled  = true
}