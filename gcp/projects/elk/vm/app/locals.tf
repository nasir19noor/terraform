locals {
  config                    = yamldecode(file("../../config.yaml"))
  region                    = local.config.global.region
  project_id                = local.config.global.project_id
  instance_name             = local.config.vm.app.instance_name
  network                   = local.config.network.vpc_name
  zone                      = local.config.vm.app.zone
  instance                  = local.config.vm.app.instance
  subnetwork                = local.config.network.subnet_name
  instance_type             = local.config.vm.app.instance_type
  disk_size_gb              = local.config.vm.app.disk_size_gb
  disk_type                 = local.config.vm.app.disk_type 
  image                     = local.config.vm.app.image
  create_internal_static_ip = local.config.vm.app.create_internal_static_ip
  create_external_static_ip = local.config.vm.app.create_external_static_ip
  allow_stopping_for_update = local.config.vm.app.allow_stopping_for_update

  service_account = {
    email = "serviceAccount:${data.google_project.project.number}-compute@developer.gserviceaccount.com"
    scopes = [
      "https://www.googleapis.com/auth/cloud-platform"
    ]
  }
}    