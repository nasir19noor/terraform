/******************************************
  Create GKE Autopilot Cluster
 *****************************************/

resource "google_container_cluster" "primary" {
  provider = google-beta

  name                     = var.name
  description              = var.description
  project                  = var.project_id
  resource_labels          = var.cluster_resource_labels
  location                 = local.location
  cluster_ipv4_cidr        = var.cluster_ipv4_cidr
  network                  = "projects/${local.network_project_id}/global/networks/${var.network}"
  enable_autopilot         = true
  datapath_provider        = var.datapath_provider
  deletion_protection      = var.deletion_protection

  lifecycle {
    ignore_changes  = [resource_labels]
    prevent_destroy = false
  }

  protect_config {
    workload_vulnerability_mode = "BASIC"
  }

  dynamic "release_channel" {
    for_each = local.release_channel

    content {
      channel = release_channel.value.channel
    }
  }

  subnetwork = "projects/${local.network_project_id}/regions/${local.region}/subnetworks/${var.subnetwork}"

  min_master_version = var.kubernetes_version

  dynamic "cluster_telemetry" {
    for_each = local.cluster_telemetry_type_is_set ? [1] : []
    content {
      type = var.cluster_telemetry_type
    }
  }

  logging_service = null
  dynamic "logging_config" {
    for_each = length(var.logging_enabled_components) > 0 ? [1] : []

    content {
      enable_components = var.logging_enabled_components
    }
  }

  monitoring_service = null
  dynamic "monitoring_config" {
    for_each = length(var.monitoring_enabled_components) > 0 ? [1] : []

    content {
      enable_components = var.monitoring_enabled_components
      managed_prometheus {
        enabled = var.enable_managed_prometheus
      }
    }
  }

  vertical_pod_autoscaling {
    enabled = var.enable_vertical_pod_autoscaling
  }

  enable_shielded_nodes = var.enable_shielded_nodes
  
  binary_authorization {
    evaluation_mode = var.enable_binary_authorization
  }

  master_authorized_networks_config {
    dynamic "cidr_blocks" {
      for_each = var.master_authorized_networks_cidr_blocks
      content {
        cidr_block   = cidr_blocks.value.cidr_block
        display_name = cidr_blocks.value.display_name
      }
    }
  }

  master_auth {
    client_certificate_config {
      issue_client_certificate = var.issue_client_certificate
    }
  }

  # Autopilot manages addons automatically, but we can still configure some
  addons_config {
    http_load_balancing {
      disabled = !var.http_load_balancing
    }

    horizontal_pod_autoscaling {
      disabled = !var.horizontal_pod_autoscaling
    }

    dns_cache_config {
      enabled = var.dns_cache_config
    }
  }

  networking_mode = var.networking_mode

  ip_allocation_policy {
    cluster_secondary_range_name  = var.ip_range_pods
    services_secondary_range_name = var.ip_range_services
  }

  maintenance_policy {
    dynamic "recurring_window" {
      for_each = local.cluster_maintenance_window_is_recurring
      content {
        start_time = var.maintenance_start_time
        end_time   = var.maintenance_end_time
        recurrence = var.maintenance_recurrence
      }
    }

    dynamic "daily_maintenance_window" {
      for_each = local.cluster_maintenance_window_is_daily
      content {
        start_time = var.maintenance_start_time
      }
    }

    dynamic "maintenance_exclusion" {
      for_each = var.maintenance_exclusions
      content {
        exclusion_name = maintenance_exclusion.value.name
        start_time     = maintenance_exclusion.value.start_time
        end_time       = maintenance_exclusion.value.end_time
      }
    }
  }

  timeouts {
    create = "45m"
    update = "45m"
    delete = "45m"
  }

  dynamic "resource_usage_export_config" {
    for_each = var.resource_usage_export_dataset_id != "" ? [{
      enable_network_egress_metering       = var.enable_network_egress_export
      enable_resource_consumption_metering = var.enable_resource_consumption_export
      dataset_id                           = var.resource_usage_export_dataset_id
    }] : []

    content {
      enable_network_egress_metering       = resource_usage_export_config.value.enable_network_egress_metering
      enable_resource_consumption_metering = resource_usage_export_config.value.enable_resource_consumption_metering
      bigquery_destination {
        dataset_id = resource_usage_export_config.value.dataset_id
      }
    }
  }

  dynamic "private_cluster_config" {
    for_each = var.enable_private_nodes ? [{
      enable_private_nodes    = var.enable_private_nodes,
      enable_private_endpoint = var.enable_private_endpoint
      master_ipv4_cidr_block  = var.master_ipv4_cidr_block
    }] : []

    content {
      enable_private_endpoint = private_cluster_config.value.enable_private_endpoint
      enable_private_nodes    = private_cluster_config.value.enable_private_nodes
      master_ipv4_cidr_block  = private_cluster_config.value.master_ipv4_cidr_block
      dynamic "master_global_access_config" {
        for_each = var.master_global_access_enabled ? [var.master_global_access_enabled] : []
        content {
          enabled = master_global_access_config.value
        }
      }
    }
  }

  dynamic "database_encryption" {
    for_each = var.database_encryption

    content {
      key_name = database_encryption.value.key_name
      state    = database_encryption.value.state
    }
  }

  dynamic "workload_identity_config" {
    for_each = local.cluster_workload_identity_config

    content {
      workload_pool = workload_identity_config.value.identity_namespace
    }
  }

  dynamic "authenticator_groups_config" {
    for_each = local.cluster_authenticator_security_group
    content {
      security_group = authenticator_groups_config.value.security_group
    }
  }
}