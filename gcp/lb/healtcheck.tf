resource "google_compute_health_check" "jenkins" {
  name     = "jenkins"
  tcp_health_check {
    port_name = "jenkins"
   // port_specification = "USE_NAMED_PORT"
    port = "8080"
  }
}