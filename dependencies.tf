locals {
    iso_name        = "https://cloud.centos.org/centos/8/x86_64/images/${var.iso_name}"
    domain_name     = "${var.project_name}.local"
    base_image_name = "${var.project_name}_base_image"
}
