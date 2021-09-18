project_name = "valyria"
iso_name = "CentOS-8-GenericCloud-8.4.2105-20210603.0.x86_64.qcow2"

nodes = {
    "master" = {
        name        = "dragonlord",
        vcpu        = 1,
        memory      = "2048",
        disk_pool   = "default",
        disk_size   = "12000000000",
        mac         = "52:54:00:11:11:00",
    },
}

# nodes = {
#     "master" = {
#         name        = "dragonlord",
#         vcpu        = 1,
#         memory      = "2048",
#         disk_pool   = "default",
#         disk_size   = "12000000000",
#         mac         = "52:54:00:11:11:00",
#     },
#     "node01" = {
#         name        = "aegon",
#         vcpu        = 1,
#         memory      = "2048",
#         disk_pool   = "default",
#         disk_size   = "12000000000",
#         mac         = "52:54:00:11:11:01",
#     },
#     "node02" = {
#         name        = "rhaenys",
#         vcpu        = 1,
#         memory      = "2048",
#         disk_pool   = "default",
#         disk_size   = "12000000000",
#         mac         = "52:54:00:11:11:02",
#     },
#     "node03" = {
#         name        = "visenya",
#         vcpu        = 1,
#         memory      = "2048",
#         disk_pool   = "default",
#         disk_size   = "12000000000",
#         mac         = "52:54:00:11:11:03",
#     },
# }
