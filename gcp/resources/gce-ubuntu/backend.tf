terraform {
  backend "gcs" {
    bucket = "terraform-state-nasir"
    prefix = "gce-ubuntu"
  }
}