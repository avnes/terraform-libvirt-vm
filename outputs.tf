output "network" {
  value = tomap({
    for k, domain in libvirt_domain.domain : k => domain.network_interface
  })
}

output "ansible_password" {
  value     = random_password.password.result
  sensitive = true
}

output "ssh_private_key_filename" {
  value = local_sensitive_file.ssh_private_key.filename
}

output "ssh_public_key_filename" {
  value = local_file.ssh_public_key.filename
}

output "ssh_command" {
  value = tomap({
    for k, domain in libvirt_domain.domain : k => (
      "ssh -i ${local_sensitive_file.ssh_private_key.filename} ansible@${domain.network_interface[0].hostname}"
    )
  })
}
