resource "google_compute_network" "vpc_network" {
  name                    = "vpc-terraform"
  auto_create_subnetworks = false
}

resource "google_compute_subnetwork" "subnet-sg" {
  name          = "subnet-sg"
  ip_cidr_range = "10.1.0.0/16"
  region        = "asia-southeast1"
  network       = google_compute_network.vpc_network.id
}

resource "google_compute_subnetwork" "subnet-id" {
  name          = "subnet-id"
  ip_cidr_range = "10.2.0.0/16"
  region        = "asia-southeast2"
  network       = google_compute_network.vpc_network.id
}  