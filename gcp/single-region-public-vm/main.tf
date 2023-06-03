terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "4.51.0"
    }
  }
}

provider "google" {
  credentials = file("gcp.json")

  project = "nasir-388602"
  region  = "asia-southeast1"
  zone    = "asia-southeast1-b"
}

resource "google_compute_network" "vpc_network" {
  name = "terrafom-network"
}