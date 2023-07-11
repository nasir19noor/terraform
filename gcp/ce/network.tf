resource "google_compute_network" "vpc_network" {
  name                    = "terraform-network"
  auto_create_subnetworks = false
}

resource "google_compute_subnetwork" "subnet-sg" {
  name          = "terraform-network-subnet-sg"
  ip_cidr_range = "10.1.0.0/16"
  region        = "asia-southeast1"
  network       = google_compute_network.vpc_network.id
}

resource "google_compute_subnetwork" "subnet-id" {
  name          = "terraform-network-subnet-id"
  ip_cidr_range = "10.2.0.0/16"
  region        = "asia-southeast2"
  network       = google_compute_network.vpc_network.id
}  