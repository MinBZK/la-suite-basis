# Add secrets permission for mijn bureau
path "secrets/*" {
  capabilities = ["read", "list"]
}
