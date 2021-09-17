output "hostnames" {
  value = [libvirt_domain.domain.*]
}
