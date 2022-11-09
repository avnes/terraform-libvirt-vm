project_name = "dev"
network_name = "bridged-network"

nodes = {
  "master" = {
    name      = "dev-node01",
    vcpu      = 1,
    memory    = "2048",
    disk_pool = "default",
    disk_size = "12000000000",
    mac       = "52:54:00:11:22:33",
  },
}
