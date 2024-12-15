module "vpc" {
  source = "../../modules/vpc"
  network_name              = "nasir"
  auto_create_subnetworks   = false
  project_id                = "nasir-441404"
  description               = "nasir"
}