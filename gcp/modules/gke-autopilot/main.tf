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

  // Autopilot doesn't use node_locations in the same way
  // It manages nodes automatically across zones

  // Kubernetes version
  master_version = var.kubernetes_version != "latest" ? var.kubernetes_version : data.google_container_engine_versions.region.latest_master_version

  release_channel = var.release_channel != null ? [{ channel : var.release_channel }] : []

  // Autopilot doesn't support manual node pool autoscaling configuration
  // Autoscaling is handled automatically

  network_project_id = var.network_project_id != "" ? var.network_project_id : var.project_id
  cluster_type       = "autopilot"

  // Autopilot doesn't support network policy configuration
  // Network policy is managed automatically

  // Service account for GKE
  service_account = var.service_account

  cluster_authenticator_security_group = var.authenticator_security_group == null ? [] : [{
    security_group = var.authenticator_security_group
  }]

  cluster_node_metadata_config = var.node_metadata == "UNSPECIFIED" ? [] : [{
    node_metadata = var.node_metadata
  }]

  // BETA features
  cluster_telemetry_type_is_set           = var.cluster_telemetry_type != null
  cluster_maintenance_window_is_recurring = var.maintenance_recurrence != "" && var.maintenance_end_time != "" ? [1] : []
  cluster_maintenance_window_is_daily     = length(local.cluster_maintenance_window_is_recurring) > 0 ? [] : [1]

  // Output values
  cluster_output_name           = google_container_cluster.primary.name
  cluster_output_regional_zones = google_container_cluster.primary.node_locations
  cluster_output_zones          = local.cluster_output_regional_zones
  cluster_endpoint              = (var.enable_private_nodes && length(google_container_cluster.primary.private_cluster_config) > 0) ? (var.deploy_using_private_endpoint ? google_container_cluster.primary.private_cluster_config.0.private_endpoint : google_container_cluster.primary.private_cluster_config.0.public_endpoint) : google_container_cluster.primary.endpoint
  cluster_peering_name          = (var.enable_private_nodes && length(google_container_cluster.primary.private_cluster_config) > 0) ? google_container_cluster.primary.private_cluster_config.0.peering_name : null
  cluster_endpoint_for_nodes    = var.master_ipv4_cidr_block
  cluster_output_master_auth    = concat(google_container_cluster.primary.*.master_auth, [])
  cluster_output_master_version = google_container_cluster.primary.master_version
  cluster_output_min_master_version = google_container_cluster.primary.min_master_version
  cluster_output_logging_service    = google_container_cluster.primary.logging_service
  cluster_output_monitoring_service = google_container_cluster.primary.monitoring_service
  
  // Autopilot doesn't have separate node pools managed by users
  cluster_output_node_pools_names    = []
  cluster_output_node_pools_versions = []
  
  cluster_master_auth_list_layer1 = local.cluster_output_master_auth
  cluster_master_auth_list_layer2 = local.cluster_master_auth_list_layer1[0]
  cluster_master_auth_map         = local.cluster_master_auth_list_layer2[0]
  cluster_location                = google_container_cluster.primary.location
  cluster_region                  = var.region
  cluster_zones                   = sort(local.cluster_output_zones)
  cluster_name                    = local.cluster_output_name
  cluster_network_tag             = "gke-${var.name}"
  cluster_ca_certificate          = local.cluster_master_auth_map["cluster_ca_certificate"]
  cluster_master_version          = local.cluster_output_master_version
  cluster_min_master_version      = local.cluster_output_min_master_version
  cluster_logging_service         = local.cluster_output_logging_service
  cluster_monitoring_service      = local.cluster_output_monitoring_service
  cluster_node_pools_names        = local.cluster_output_node_pools_names
  cluster_node_pools_versions     = local.cluster_output_node_pools_versions
  
  workload_identity_enabled = !(var.identity_namespace == null || var.identity_namespace == "null")
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

/******************************************
  Create GKE Autopilot Cluster
 *****************************************/
resource "google_container_cluster" "primary" {
  provider = google

  name     = var.name
  project  = var.project_id
  location = local.location

  // Autopilot cluster configuration
  enable_autopilot = true

  // Release channel (recommended for Autopilot)
  dynamic "release_channel" {
    for_each = local.release_channel
    content {
      channel = release_channel.value.channel
    }
  }

  // Network configuration
  network    = var.network
  subnetwork = var.subnetwork

  // Private cluster configuration
  dynamic "private_cluster_config" {
    for_each = var.enable_private_nodes ? [1] : []
    content {
      enable_private_nodes    = true
      enable_private_endpoint = var.enable_private_endpoint
      master_ipv4_cidr_block  = var.master_ipv4_cidr_block
      
      dynamic "master_global_access_config" {
        for_each = var.master_global_access_enabled ? [1] : []
        content {
          enabled = true
        }
      }
    }
  }

  // IP allocation policy
  dynamic "ip_allocation_policy" {
    for_each = var.ip_range_pods != "" || var.ip_range_services != "" ? [1] : []
    content {
      cluster_secondary_range_name  = var.ip_range_pods
      services_secondary_range_name = var.ip_range_services
    }
  }

  // Master authorized networks
  dynamic "master_authorized_networks_config" {
    for_each = var.master_authorized_networks != null ? [1] : []
    content {
      dynamic "cidr_blocks" {
        for_each = var.master_authorized_networks
        content {
          cidr_block   = cidr_blocks.value.cidr_block
          display_name = lookup(cidr_blocks.value, "display_name", null)
        }
      }
    }
  }

  // Workload Identity
  dynamic "workload_identity_config" {
    for_each = local.cluster_workload_identity_config
    content {
      workload_pool = workload_identity_config.value.identity_namespace
    }
  }

  // Maintenance window
  dynamic "maintenance_policy" {
    for_each = local.cluster_maintenance_window_is_recurring
    content {
      dynamic "recurring_window" {
        for_each = local.cluster_maintenance_window_is_recurring
        content {
          start_time = var.maintenance_start_time
          end_time   = var.maintenance_end_time
          recurrence = var.maintenance_recurrence
        }
      }
    }
  }

  dynamic "maintenance_policy" {
    for_each = local.cluster_maintenance_window_is_daily
    content {
      daily_maintenance_window {
        start_time = var.maintenance_start_time
      }
    }
  }

  // Logging and monitoring
  logging_service    = var.logging_service
  monitoring_service = var.monitoring_service

  // Resource labels
  resource_labels = var.cluster_resource_labels

  // Autopilot-specific features
  // Note: Many addons and features are automatically managed in Autopilot
  
  // Security posture (if needed)
  dynamic "security_posture_config" {
    for_each = var.enable_security_posture ? [1] : []
    content {
      mode               = var.security_posture_mode
      vulnerability_mode = var.security_posture_vulnerability_mode
    }
  }

  // Binary authorization
  dynamic "binary_authorization" {
    for_each = var.enable_binary_authorization ? [1] : []
    content {
      evaluation_mode = var.binary_authorization_evaluation_mode
    }
  }
  deletion_protection = var.deletion_protection
}