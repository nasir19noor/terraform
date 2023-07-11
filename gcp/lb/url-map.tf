resource "google_compute_url_map" "jenkins" {
  name            = "jenkins"
  default_service = google_compute_backend_service.jenkins.id
}