resource "google_compute_instance" "jenkins" {
  name         = "jenkins"
  machine_type = "e2-micro"
  zone         = "asia-southeast1-b"
  //desired_status = "RUNNING"

  boot_disk {
    initialize_params {
      image = "ubuntu-os-cloud/ubuntu-2204-lts"
    }
  }

  network_interface {
    network    = google_compute_network.vpc_network.id
    subnetwork = google_compute_subnetwork.subnet-sg.id
    access_config {
      nat_ip = google_compute_address.static-ip-sg.address
    }
  }
}
resource "google_compute_address" "static_ip" {
  name = "terraform-static-ip"
}

resource "google_compute_address" "static-ip-sg" {
  name         = "jenkins"
  address_type = "EXTERNAL"
  region       = "asia-southeast1"
}
