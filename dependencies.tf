locals {
    domain_name     = "${var.project_name}.local"
    base_image_name = "${var.project_name}_base_image"
    cloud_image_url = "${var.cloud_image_base_url}/${var.cloud_image_name}"
}
