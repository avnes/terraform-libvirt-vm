terraform {
  required_version = ">= 1.0.0"

  required_providers {
    libvirt = {
      source  = "dmacvicar/libvirt"
    }

    # TODO: Deprecated: https://registry.terraform.io/providers/hashicorp/template/latest/docs
    template = {
      source = "hashicorp/template"
    }

    tls = {
      source = "hashicorp/tls"
    }

    local = {
      source = "hashicorp/local"
    }

    random = {
      source = "hashicorp/random"
    }
  }
}
