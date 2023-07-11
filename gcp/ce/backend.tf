terraform {
  backend "gcs" {
    bucket      = "nasir-terraform"
    prefix      = "v1"
    credentials = "nasir.json"
  }
}