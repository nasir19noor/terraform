resource "google_compute_backend_service" "jenkins" {
  name                    = "jenkins"
  //provider                = google-beta
  protocol                = "HTTP"
  port_name               = "jenkins"
  load_balancing_scheme   = "EXTERNAL"
  timeout_sec             = 10
  enable_cdn              = true
  health_checks           = [google_compute_health_check.jenkins.id]
  backend {
    group           = google_compute_instance_group.jenkins.self_link
    balancing_mode  = "UTILIZATION"
  }
}