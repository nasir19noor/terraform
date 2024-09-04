terraform {
  backend "gcs" {
    bucket = "terraform-state-nasir"
    prefix = "subnets"
  }
}