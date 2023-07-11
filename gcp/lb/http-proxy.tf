resource "google_compute_target_http_proxy" "jenkins" {
  name     = "jenkins"
  //region = "asia-southeast1"
  url_map  = google_compute_url_map.jenkins.id
}