terraform {
  required_version = ">= 1.0.0"

  required_providers {
    libvirt = {
      source  = "dmacvicar/libvirt"
      version = "0.6.11"
    }

    # TODO: Deprecated: https://registry.terraform.io/providers/hashicorp/template/latest/docs
    template = {
      source = "hashicorp/template"
      version = "2.2.0"
    }

    tls = {
      source = "hashicorp/tls"
      version = "3.1.0"
    }

    local = {
      source = "hashicorp/local"
      version = "2.1.0"
    }
  }
}
