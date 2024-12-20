# Add secrets permission for mijn bureau
path "secrets/*" {
  capabilities = ["create", "read", "update", "patch", "list"]
}
