terraform {
  backend "gcs" {
    bucket = "gcs-prj-b-seed-tfstate-lce"
    prefix = "5-app-infra/dev/asia-south1/gce/dev-saas-gce-management-vm"
  }
}