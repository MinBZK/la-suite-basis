disable_mlock = true
ui = true

listener "tcp" {
    tls_disable = 1
    address = "[::]:8200"
    cluster_address = "[::]:8201"
}

storage "raft" {
  path    = "/vault/data"
}

default_lease_ttl="768h"
max_lease_ttl="768h"