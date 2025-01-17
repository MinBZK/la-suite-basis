# Allow all access for admins
path "*" {
    capabilities = ["create", "read", "update", "delete", "list", "sudo"]
}
