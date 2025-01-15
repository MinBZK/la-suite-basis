#!/usr/bin/env bash

export VAULT_ADDR='https://secret.la-suite.apps.digilab.network'

if [ -z "$VAULT_TOKEN" ]; then
  echo "VAULT_TOKEN is not set"
  exit 1
fi

# enable auditing
vault audit enable file file_path=/vault/data/vault_audit.log

# create policies 
vault policy write default policy-default.hcl
vault policy write mijn-bureau-team policy-mijn-bureau.hcl
vault policy write admin-team policy-admin.hcl
vault policy write viewer-team policy-viewer.hcl

# enable oidc auth
vault auth enable oidc
vault write auth/oidc/config \
         oidc_discovery_url="https://id.la-suite.apps.digilab.network/realms/lasuite" \
         oidc_client_id="vault" \
         oidc_client_secret="xxx" \
         default_role="default"

vault write auth/oidc/role/default \
      bound_audiences="vault" \
      allowed_redirect_uris="https://secret.la-suite.apps.digilab.network/ui/vault/auth/oidc/oidc/callback" \
      allowed_redirect_uris="https://secret.la-suite.apps.digilab.network/oidc/callback" \
      user_claim="email" \
      oidc_scopes="email,profile,roles" \
      token_policies="default" \
      claim_mappings={"email"="email","sub"="sub","name"="name"}

vault write auth/oidc/role/viewer \
      bound_audiences="vault" \
      allowed_redirect_uris="https://secret.la-suite.apps.digilab.network/ui/vault/auth/oidc/oidc/callback" \
      allowed_redirect_uris="https://secret.la-suite.apps.digilab.network/oidc/callback" \
      user_claim="email" \
      oidc_scopes="email,profile,roles" \
      token_policies="viewer-team" \
      claim_mappings={"email"="email","sub"="sub","name"="name"} \
      bound_claims={"/resource_access/vault/roles":"viewer"}

vault write auth/oidc/role/admin \
      bound_audiences="vault" \
      allowed_redirect_uris="https://secret.la-suite.apps.digilab.network/ui/vault/auth/oidc/oidc/callback" \
      allowed_redirect_uris="https://secret.la-suite.apps.digilab.network/oidc/callback" \
      user_claim="email" \
      oidc_scopes="email,profile,roles" \
      token_policies="admin-team" \
      claim_mappings={"email"="email","sub"="sub","name"="name"} \
      bound_claims={"/resource_access/vault/roles":"admin"}

# enable kv store
vault secrets enable -path=secrets -version=2 kv

# enable totp
vault secrets enable totp
vault write totp/keys/opendeskdefaultadmin url="xxx"
vault write totp/keys/opendeskadmin url="xxx"
vault write totp/keys/keycloakadmin url="xxx"
