provider "libvirt" {
    uri = "qemu:///system"
}

resource "libvirt_volume" "base_image_volume" {
    name   = local.base_image_name
    source = local.iso_name
    pool   = var.disk_pool
}

resource "libvirt_volume" "node_volume" {
  for_each = var.nodes
  name           = "${each.value.name}.qcow2"
  base_volume_id = libvirt_volume.base_image_volume.id
  pool           = each.value.disk_pool
  format         = "qcow2"
  size           = each.value.disk_size
}

data "template_file" "cloud_init" {
  template = file("${path.module}/cloud_init.cfg")
  for_each   = var.nodes
  vars     = {
    hostname   = each.value.name
    domainname = local.domain_name
  }
}

resource "libvirt_cloudinit_disk" "init_disk" {
  for_each   = var.nodes
  name      = "${each.value.name}_init_disk.iso"
  user_data = data.template_file.cloud_init[each.key].rendered
}

resource "libvirt_domain" "domain" {
  for_each   = var.nodes
  name   = each.value.name
  memory = each.value.memory
  vcpu   = each.value.vcpu

  network_interface {
    network_name   = var.network_name
    mac            = each.value.mac
    wait_for_lease = var.network_name == "host-bridge" ? false : true
  }

  disk {
    volume_id = element(libvirt_volume.node_volume[each.key].*.id, 1 )
  }

  cloudinit = libvirt_cloudinit_disk.init_disk[each.key].id

}
