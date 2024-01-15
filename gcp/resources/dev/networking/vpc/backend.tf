terraform {
  backend "gcs" {
    bucket = "nasir-terraform-state-wo-modules"
    prefix = "dev/networking/vpc"
  }
}