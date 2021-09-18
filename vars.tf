variable "project_name" {
    type = string
    default = null
    description = "The project name is used for grouping the VMs"
}

variable "iso_name" {
    type = string
    default = null
    description = "The ISO file filename"
}

variable "disk_pool" {
    type = string
    default = "default"
    description = "The name of the libvirt image disk pool"
}

variable "network_name" {
    type = string
    default = "default"
    description = "The name of the libvirt network"
}

variable "nodes" {
    type = map
    default = {}
    description = "A map of maps with server details. Please see example in README"
}
