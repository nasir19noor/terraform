provider "google" {
  version = "4.69.0"

  credentials = file("nasir.json")

  project = "nasir-392004"
  region  = "asia-southeast1"
  zone    = "asia-southeast1-c"
}

module "network" {
  source  = "terraform-google-modules/network/google"
  version = "7.1.0"

  network_name = "terraform-vpc-network"
  project_id   = var.project

  subnets = [
    {
      subnet_name   = "subnet-01"
      subnet_ip     = var.cidr
      subnet_region = var.region
    },
    {
      subnet_name   = "subnet-02"
      subnet_ip     = "10.2.0.0/16"
      subnet_region = var.region
      google_private_access = "true"
    },
  ]

  secondary_ranges = {
    subnet-01 = []

  }
}

module "network_routes" {
  source  = "terraform-google-modules/network/google//modules/routes"
  version = "7.1.0"
  network_name = module.network.network_name
  project_id   = var.project
  
   routes = [
         {
             name                   = "egress-internet"
             description            = "route through IGW to access internet"
             destination_range      = "0.0.0.0/0"
             tags                   = "egress-inet"
             next_hop_internet      = "true"
         },
     ]
  }
    
module "network_fabric-net-firewall" {
  source  = "terraform-google-modules/network/google//modules/fabric-net-firewall"
  version = "7.1.0"
  project_id              = var.project
  network                 = module.network.network_name
  internal_ranges_enabled = true
  internal_ranges         = var.cidr

}