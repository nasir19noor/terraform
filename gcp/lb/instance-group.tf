resource "google_compute_instance_group" "jenkins" {
  name        = "jenkins"
  description = "jenkins instance group"

  instances = [
    "${google_compute_instance.jenkins.self_link}",
  ]

  named_port {
    name = "jenkins"
    port = "8080"
  }

  zone = "asia-southeast1-b"
}