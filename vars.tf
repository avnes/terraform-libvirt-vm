variable "project_name" {
  type        = string
  default     = null
  description = "The project name is used for grouping the VMs"
}

variable "cloud_image_name" {
  type        = string
  default     = "CentOS-Stream-GenericCloud-8-20210603.0.x86_64.qcow2"
  description = "The cloud image file filename"
}

variable "cloud_image_base_url" {
  type        = string
  default     = "https://cloud.centos.org/centos/8-stream/x86_64/images"
  description = "The base URL for the cloud image files"
}

variable "disk_pool" {
  type        = string
  default     = "default"
  description = "The name of the libvirt image disk pool"
}

variable "network_name" {
  type        = string
  default     = "default"
  description = "The name of the libvirt network"
}

variable "bridge_name" {
  type        = string
  default     = "virbr0"
  description = "The name of the libvirt bridge adapter"
}

variable "qemu_agent" {
  type        = bool
  default     = true
  description = "Add Qemu guest agent"
}

variable "nodes" {
  type        = map(any)
  default     = {}
  description = "A map of maps with server details. Please see example in README"
}
