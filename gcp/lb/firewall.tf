resource "google_compute_firewall" "allow-ssh" {
  name    = "terraform-allow-ssh"
  network = google_compute_network.vpc_network.id
  allow {
    protocol = "tcp"
    ports    = ["22"]
  }
  source_ranges = ["0.0.0.0/0"]
}

resource "google_compute_firewall" "allow-http" {
  name    = "terraform-allow-http"
  network = google_compute_network.vpc_network.id
  allow {
    protocol = "tcp"
    ports    = ["80"]
  }
  source_ranges = ["0.0.0.0/0"]
}

resource "google_compute_firewall" "allow-http-8080" {
  name    = "terraform-allow-http-8080"
  network = google_compute_network.vpc_network.id
  allow {
    protocol = "tcp"
    ports    = ["8080"]
  }
  source_ranges = ["0.0.0.0/0"]
}

resource "google_compute_firewall" "allow-https" {
  name    = "terraform-allow-https"
  network = google_compute_network.vpc_network.id
  allow {
    protocol = "tcp"
    ports    = ["443"]
  }
  source_ranges = ["0.0.0.0/0"]
}

resource "google_compute_firewall" "allow-internal" {
  name    = "terraform-allow-internal"
  network = google_compute_network.vpc_network.id
  allow {
    protocol = "tcp"
    ports    = ["1-65535"]
  }
  allow {
    protocol = "udp"
    ports    = ["1-65535"]
  }
  allow {
    protocol = "icmp"
  }
  source_ranges = ["10.0.0.0/8", "10.0.0.0/8", "10.0.0.0/8"]
}