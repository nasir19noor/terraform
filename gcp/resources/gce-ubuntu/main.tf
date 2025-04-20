module "ubuntu-instance" {
  source                    = "../../modules/gce"
  instance_name             = var.instance_name
  project                   = var.project
  network_project_id        = var.network_project_id
  region                    = var.region
  zone                      = var.zone
  instance                  = var.instance
  network                   = var.network
  subnetwork                = var.subnetwork
  instance_type             = var.instance_type
  disk_size_gb              = var.disk_size_gb
  disk_type                 = var.disk_type
  image                     = var.image
  # service_account           = var.service_account
  create_internal_static_ip = true
  create_external_static_ip = true
  allow_stopping_for_update = var.allow_stopping_for_update

  tags   = ["management-vm"]
  labels = { environment = "dev", team = "saascommon", name = "dev-saas-gce-management-vm", creation-mode = "tf", os = "ubuntu" }
}
