locals {
  config                    = yamldecode(file("../config.yaml"))
  region                    = local.config.global.region
  project_id                = local.config.global.project_id
  instance_name             = local.config.k8s-master.instance_name
  network                   = local.config.network.vpc_name
  zone                      = local.config.k8s-master.zone
  instance                  = local.config.k8s-master.instance
  subnetwork                = local.config.network.subnet_name
  instance_type             = local.config.k8s-master.instance_type
  disk_size_gb              = local.config.k8s-master.disk_size_gb
  disk_type                 = local.config.k8s-master.disk_type 
  image                     = local.config.k8s-master.image
  create_internal_static_ip = local.config.k8s-master.create_internal_static_ip
  create_external_static_ip = local.config.k8s-master.create_external_static_ip
  allow_stopping_for_update = local.config.k8s-master.allow_stopping_for_update

  service_account = {
    email = "serviceAccount:${data.google_project.project.number}-compute@developer.gserviceaccount.com"
    scopes = [
      "https://www.googleapis.com/auth/cloud-platform"
    ]
  }
}    