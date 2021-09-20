# valyria-vm

Used to create kvm/qemu/libvirt VMs through automation using Terraform. These will eventually be used to power my Kubernetes playground at home.

## Credits

Thanks to the blog <https://www.desgehtfei.net/en/quick-start-kvm-libvirt-vms-with-terraform-and-ansible-part-1-2/> for a lot of inspiration.

## Security

This repository contains some dummy passwords the root account. This is intentional. I will have other automation to replace these passwords when hardening the infrastructure.

## Requirements

### Install virtualization software

Please note that these instructions are written for Fedora.

```bash
sudo dnf install libvirt cockpit cockpit-machines
sudo systemctl enable cockpit.socket --now
sudo systemctl enable libvirtd --now
sudo firewall-cmd --zone=public --add-service=cockpit --permanent
sudo firewall-cmd --reload
```

### Install Terraform

```bash
sudo dnf config-manager --add-repo https://rpm.releases.hashicorp.com/fedora/hashicorp.repo
sudo dnf install -y terraform
```

### Allow using libvirt

You will need to add your regular Linux user to be able to use libvirt:

```bash
sudo usermod -a -G libvirt $(whoami)
```

Now logout, and login again to activate your membership in the libvirt group.

## Create VMs with terraform

### Define variables

Create a file called terraform.tfvars with content similar to this:

```hcl
project_name = "valyria"

nodes = {
    "master" = {
        name        = "targaryen",
        vcpu        = 1,
        memory      = "2048",
        disk_pool   = "default",
        disk_size   = "12000000000",
        mac         = "52:54:00:11:22:33",
    },
}
```

If you want to use a remote backend to store the state, also create a file called backend.tf.

More info about Terraform backends at <https://www.terraform.io/docs/language/settings/backends/>

```bash
cd valyria-vm
terraform init # Or: terraform init -backend-config=backend.tf
terraform apply
```
