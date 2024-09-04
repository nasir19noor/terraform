terraform {
  backend "gcs" {
    bucket = "terraform-state-nasir"
    prefix = "vpc"
  }
}