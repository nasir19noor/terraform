provider "google" {
  version = "4.69.0"

  credentials = file("nasir.json")

  project = "nasir-392004"
  region  = "asia-southeast1"
  zone    = "asia-southeast1-c"
}