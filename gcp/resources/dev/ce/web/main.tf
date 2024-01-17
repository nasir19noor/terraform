resource "google_compute_network" "vpc_network" {
  name = "terraform-network"
}

resource "google_compute_instance" "dev_web" {
  name = "dev_web"
  machine_type = "f1-micro"
  zone = "us-central1-c"
  boot_disk {
    initialize_params {
    image = "centos-cloud/centos-7"
  }
}