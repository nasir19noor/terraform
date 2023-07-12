resource "google_compute_global_forwarding_rule" "jenkins" {
  name                  = "jenkins"
  //region                = "global"
  //depends_on            = [google_compute_subnetwork.proxy_subnet]
  //ip_protocol           = "TCP"
  load_balancing_scheme = "EXTERNAL"
  port_range            = "80"
  target                = google_compute_target_http_proxy.jenkins.id
  ///ip_address = google_compute_address.jenkins-fe-2.address
  //network               = google_compute_network.vpc_network.id
  //subnetwork            = google_compute_subnetwork.subnet-sg.id
  //network_tier          = "PREMIUM"
}


//resource "google_compute_address" "jenkins-fe-2" {
//  address_type = "EXTERNAL"
 // region       = "asia-southeast1"
//}