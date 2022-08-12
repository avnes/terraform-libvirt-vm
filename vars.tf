variable "project_name" {
  type        = string
  default     = null
  description = "The project name is used for grouping the VMs"
}

variable "domain_name" {
  type        = string
  default     = "localdomain"
  description = "The DNS domain name to use"
}

variable "cloud_image_name" {
  type        = string
  default     = "CentOS-Stream-GenericCloud-8-20220125.1.x86_64.qcow2"
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

variable "qemu_agent" {
  type        = bool
  default     = true
  description = "Add Qemu guest agent"
}

variable "wait_for_lease" {
  type        = bool
  default     = false
  description = "Wait until the network interface gets a DHCP lease from libvirt, so that the computed IP addresses will be available when the domain is up and the plan applied."
}

variable "nodes" {
  type        = map(any)
  default     = {}
  description = "A map of maps with server details. Please see example in README"
}

variable "custom_cmd" {
  type        = string
  default     = "touch /var/log/dummy.log"
  description = "Run one custom runcmd in cloud-init"
}
