locals {
  realm_id  = "grafana"
  client_id = "grafana"
  users = {
    admin: "Admin",
    editor: "Editor",
    viewer: "Viewer"
  }
}

#create realm
resource "keycloak_realm" "grafana_realm" {
  realm       = local.realm_id
  enabled     = true
  display_name = local.realm_id
}

# create realm roles
resource "keycloak_role" "realm_role" {
  for_each        = local.users
  realm_id        = keycloak_realm.grafana_realm.id
  name            = each.value
}

# create users
resource "keycloak_user" "users" {
  for_each       = local.users
  realm_id       = keycloak_realm.grafana_realm.id
  username       = each.key
  enabled        = true
  email          = "${each.key}@domain.com"
  email_verified = true
  first_name     = each.value
  last_name      = each.value
  initial_password {
    value = each.key
  }
}

# assign realm roles
# TODO funktioniert noch nicht
resource "keycloak_user_roles" "user_roles" {
  for_each = toset(["admin", "editor", "viewer"])
  realm_id = keycloak_realm.grafana_realm.id
  user_id  = lookup(keycloak_user.users, each.key).id

  role_ids = [
    lookup(keycloak_role.realm_role, each.key).id
  ]
}

# create grafana openid client
resource "keycloak_openid_client" "grafana_client" {
  realm_id                      = keycloak_realm.grafana_realm.id
  client_id                     = local.client_id
  name                          = local.client_id
  enabled                       = true
  access_type                   = "CONFIDENTIAL"
  client_secret                 = "grafana-client-secret"
  standard_flow_enabled         = true
  direct_access_grants_enabled  = true
  valid_redirect_uris           = [
    "*"
  ]
}

#create role mapper for client
resource "keycloak_openid_user_realm_role_protocol_mapper" "user_realm_role_mapper" {
  realm_id    = keycloak_realm.grafana_realm.id
  client_id   = keycloak_openid_client.grafana_client.id
  name        = "roles"
  multivalued = true
  claim_name  = "roles"
}