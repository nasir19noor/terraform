provider "google" {
  project = var.project_id
  region  = var.region
}

data "google_compute_zones" "dev" {
  region  = var.region
  project = var.project_id
}

locals {
  type   = ["public", "private"]
  zones = data.google_compute_zones.dev.names
}

# VPC
resource "google_compute_network" "dev" {
  name                            = "${var.name}-vpc"
  delete_default_routes_on_create = false
  auto_create_subnetworks         = false
  routing_mode                    = "REGIONAL"
}

#Subnets 
resource"google_compute_subnetwork" "dev" {
  count= 2
  name="${var.name}-${local.type[count.index]}-subnetwork"
  ip_cidr_range= var.ip_cidr_range[count.index]
  region=var.region
  network=google_compute_network.dev.id
  private_ip_google_access =true
}