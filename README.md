# terraform-libvirt-vm

Used to create kvm/qemu/libvirt VMs with CentOS Stream server through automation using Terraform. These will eventually be used to power my Kubernetes playground at home.

## Credits

Thanks to the blog <https://www.desgehtfei.net/en/quick-start-kvm-libvirt-vms-with-terraform-and-ansible-part-1-2/> for a lot of inspiration.

## Requirements

### Install virtualization software

Please note that these instructions are written for Fedora and CentOS Stream:

```bash
sudo dnf install libvirt cockpit cockpit-machines virt-manager
sudo systemctl enable cockpit.socket --now
sudo systemctl enable libvirtd --now
sudo firewall-cmd --zone=public --add-service=cockpit --permanent
sudo firewall-cmd --reload
```

### Configure DNS


A low cost solution is to run `sudo virsh net-edit default` and add this element

```
  <dns>
    <host ip='192.168.122.1'>
      <hostname>gateway</hostname>
    </host>
  </dns>
```

Where 192.168.122.1 must match the address for your libvirt networks's gateway IP. Then edit /etc/resolve.conf and add `nameserver 192.168.122.1` as the first nameserver in the file. You will now be able to use 'nslookup' on the server names created by libvirt.

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
project_name = "dragonstone"

nodes = {
    "master" = {
        name        = "targaryen",
        vcpu        = 2,
        memory      = "8196",
        disk_pool   = "default",
        disk_size   = "12000000000",
        mac         = "52:54:00:11:22:33",
    },
}
```

If you want to use a remote backend to store the state, also create a file called backend.tf.

More info about Terraform backends at <https://www.terraform.io/docs/language/settings/backends/>

```bash
cd terraform-libvirt-vm
terraform init  # Or: terraform init -backend-config=/path-to/backend.tf
terraform apply # Or: terraform apply -var-file=/path-to/terraform.tfvars
```
