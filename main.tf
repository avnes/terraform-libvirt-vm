provider "libvirt" {
  uri = "qemu:///system"
}

resource "tls_private_key" "private_key" {
  algorithm = "RSA"
}

resource "local_sensitive_file" "ssh_private_key" {
  content         = tls_private_key.private_key.private_key_pem
  filename        = pathexpand("~/.ssh/${var.project_name}.pem")
  file_permission = "0600"
}

resource "local_file" "ssh_public_key" {
  content         = tls_private_key.private_key.public_key_openssh
  filename        = pathexpand("~/.ssh/${var.project_name}.pub")
  file_permission = "0644"
}

resource "random_password" "password" {
  length           = 32
  special          = true
  override_special = "!@#$%&*-_=+:?"
}

resource "libvirt_volume" "base_image_volume" {
  name   = local.base_image_name
  source = local.cloud_image_url
  pool   = var.disk_pool
}

resource "libvirt_volume" "node_volume" {
  for_each       = var.nodes
  name           = "${each.value.name}.qcow2"
  base_volume_id = libvirt_volume.base_image_volume.id
  pool           = each.value.disk_pool
  format         = "qcow2"
  size           = each.value.disk_size
}

data "template_file" "cloud_init" {
  template = file("${path.module}/cloud_init.cfg")
  for_each = var.nodes
  vars = {
    hostname         = each.value.name
    domainname       = var.domain_name
    custom_cmd       = var.custom_cmd
    ssh_pub_key      = tls_private_key.private_key.public_key_openssh
    ansible_password = random_password.password.result
  }
}

resource "libvirt_cloudinit_disk" "init_disk" {
  for_each  = var.nodes
  name      = "${each.value.name}_init_disk.iso"
  user_data = data.template_file.cloud_init[each.key].rendered
}

resource "libvirt_domain" "domain" {
  for_each   = var.nodes
  name       = each.value.name
  memory     = each.value.memory
  vcpu       = each.value.vcpu
  qemu_agent = var.qemu_agent

  network_interface {
    network_name   = var.network_name
    hostname       = each.value.name
    mac            = each.value.mac
    wait_for_lease = var.wait_for_lease
  }

  disk {
    volume_id = element(libvirt_volume.node_volume[each.key].*.id, 1)
  }

  graphics {
    type        = "vnc"
    listen_type = "address"
  }

  cloudinit = libvirt_cloudinit_disk.init_disk[each.key].id

}
