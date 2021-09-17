terraform {
  required_version = ">= 1.0.0"

  required_providers {
    libvirt = {
      source  = "dmacvicar/libvirt"
      version = "0.6.11"
    }

    # Deprecated: https://registry.terraform.io/providers/hashicorp/template/latest/docs
    template = {
      source = "hashicorp/template"
      version = "2.2.0"
    }
  }
}
