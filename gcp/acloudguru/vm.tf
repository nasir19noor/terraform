resource "google_compute_instance" "vm_instance_sg" {
  name         = "terraform-instance-sg"
  machine_type = "e2-micro"
  zone         = "asia-southeast1-b"
  desired_status = "TERMINATED"

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-12"
    }
  }

  network_interface {
    network = google_compute_network.vpc_network.id
    subnetwork = google_compute_subnetwork.subnet-sg.id
    access_config {
        nat_ip = google_compute_address.static-ip-sg.address
    }
  }
}
resource "google_compute_address" "static_ip" {
  name = "terraform-static-ip-2"
}

resource "google_compute_address" "static-ip-sg" {
  name = "terraform-static-ip-external-sg"
  address_type = "EXTERNAL"
  region = "asia-southeast1"
}

resource "google_compute_instance" "vm_instance_id" {
  name         = "terraform-instance-id"
  machine_type = "e2-small"
  zone         = "asia-southeast2-c"
  desired_status = "TERMINATED"
  allow_stopping_for_update = true 

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-12"
    }
  }  

  network_interface {
    network = google_compute_network.vpc_network.id
    subnetwork = google_compute_subnetwork.subnet-id.id
    access_config {
        nat_ip = google_compute_address.static-ip-id.address     
    }
  }
}

resource "google_compute_address" "static_ip-id" {
  name = "terraform-static-ip-id"
}

resource "google_compute_address" "static-ip-id" {
  name = "terraform-static-ip-external-id"
  address_type = "EXTERNAL"
  region = "asia-southeast2"
}