/******************************************
  Get available zones in region
 *****************************************/

data "google_compute_zones" "available" {
  provider = google

  project = var.project_id
  region  = local.region
}

resource "random_shuffle" "available_zones" {
  input        = data.google_compute_zones.available.names
  result_count = 3
}

locals {
  // ID of the cluster
  cluster_id = google_container_cluster.primary.id

  // location - Autopilot clusters are always regional
  location = var.region
  region   = var.region

  // Kubernetes version
  master_version = var.kubernetes_version != "latest" ? var.kubernetes_version : data.google_container_engine_versions.region.latest_master_version

  release_channel = var.release_channel != null ? [{ channel : var.release_channel }] : []

  network_project_id = var.network_project_id != "" ? var.network_project_id : var.project_id
  cluster_type       = "autopilot"

  cluster_authenticator_security_group = var.authenticator_security_group == null ? [] : [{
    security_group = var.authenticator_security_group
  }]

  // BETA features
  cluster_telemetry_type_is_set           = var.cluster_telemetry_type != null
  cluster_maintenance_window_is_recurring = var.maintenance_recurrence != "" && var.maintenance_end_time != "" ? [1] : []
  cluster_maintenance_window_is_daily     = length(local.cluster_maintenance_window_is_recurring) > 0 ? [] : [1]

  // Output values
  cluster_output_name                               = google_container_cluster.primary.name
  cluster_output_regional_zones                     = google_container_cluster.primary.node_locations
  cluster_output_zones                              = local.cluster_output_regional_zones
  cluster_endpoint                                  = (var.enable_private_nodes && length(google_container_cluster.primary.private_cluster_config) > 0) ? (var.deploy_using_private_endpoint ? google_container_cluster.primary.private_cluster_config.0.private_endpoint : google_container_cluster.primary.private_cluster_config.0.public_endpoint) : google_container_cluster.primary.endpoint
  cluster_peering_name                              = (var.enable_private_nodes && length(google_container_cluster.primary.private_cluster_config) > 0) ? google_container_cluster.primary.private_cluster_config.0.peering_name : null
  cluster_endpoint_for_nodes                        = var.master_ipv4_cidr_block
  cluster_output_master_auth                        = concat(google_container_cluster.primary.*.master_auth, [])
  cluster_output_master_version                     = google_container_cluster.primary.master_version
  cluster_output_min_master_version                 = google_container_cluster.primary.min_master_version
  cluster_output_logging_service                    = google_container_cluster.primary.logging_service
  cluster_output_monitoring_service                 = google_container_cluster.primary.monitoring_service
  cluster_output_http_load_balancing_enabled        = google_container_cluster.primary.addons_config.0.http_load_balancing.0.disabled
  cluster_output_horizontal_pod_autoscaling_enabled = google_container_cluster.primary.addons_config.0.horizontal_pod_autoscaling.0.disabled
  cluster_master_auth_list_layer1                   = local.cluster_output_master_auth
  cluster_master_auth_list_layer2                   = local.cluster_master_auth_list_layer1[0]
  cluster_master_auth_map                           = local.cluster_master_auth_list_layer2[0]
  cluster_location                                  = google_container_cluster.primary.location
  cluster_region                                    = var.region
  cluster_zones                                     = sort(local.cluster_output_zones)
  cluster_name                                      = local.cluster_output_name
  cluster_network_tag                               = "gke-${var.name}"
  cluster_ca_certificate                            = local.cluster_master_auth_map["cluster_ca_certificate"]
  cluster_master_version                            = local.cluster_output_master_version
  cluster_min_master_version                        = local.cluster_output_min_master_version
  cluster_logging_service                           = local.cluster_output_logging_service
  cluster_monitoring_service                        = local.cluster_output_monitoring_service
  cluster_http_load_balancing_enabled               = !local.cluster_output_http_load_balancing_enabled
  cluster_horizontal_pod_autoscaling_enabled        = !local.cluster_output_horizontal_pod_autoscaling_enabled
  workload_identity_enabled                         = !(var.identity_namespace == null || var.identity_namespace == "null")
  cluster_workload_identity_config = !local.workload_identity_enabled ? [] : var.identity_namespace == "enabled" ? [{
    identity_namespace = "${var.project_id}.svc.id.goog" }] : [{ identity_namespace = var.identity_namespace
  }]
}

/******************************************
  Get available container engine versions
 *****************************************/
data "google_container_engine_versions" "region" {
  location = local.location
  project  = var.project_id
}

