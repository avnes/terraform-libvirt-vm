output "hostnames" {
  value = [libvirt_domain.domain.*]
}

output "ansible_password" {
  value     = random_password.password.result
  sensitive = true
}
