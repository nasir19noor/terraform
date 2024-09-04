module "subnets" {
  source       = "../../modules/subnets"
  project_id   = "nasir-434503"
  network_name = "nasir"
#   region       = "asia-southeast-1"

  subnets = [
    {
      subnet_name   = "gke"
      subnet_ip     = "10.21.0.0/21"
      subnet_region = "asia-southeast1"
    },
    {
      subnet_name   = "workload"
      subnet_ip     = "10.21.15.0/24"
      subnet_region = "asia-southeast1"
    }
  ]

  secondary_ranges = {
    gke = [
      {
        range_name    = "pod"
        ip_cidr_range = "10.20.0.0/16"
      },
      {
        range_name    = "service"
        ip_cidr_range = "10.21.8.0/22"
      }
    ]
  }
}