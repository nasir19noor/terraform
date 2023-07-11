terraform {
  backend "gcs" {
    bucket      = "nasir-terraform"
    prefix      = "lb"
    credentials = "nasir.json"
  }
}