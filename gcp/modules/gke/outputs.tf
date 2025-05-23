output "cluster_id" {
  description = "Cluster ID"
  value       = local.cluster_id
}
output "name" {
  description = "Cluster name"
  value       = local.cluster_name
}

output "type" {
  description = "Cluster type (regional / zonal)"
  value       = local.cluster_type
}

output "location" {
  description = "Cluster location (region if regional cluster, zone if zonal cluster)"
  value       = local.cluster_location
}

output "region" {
  description = "Cluster region"
  value       = local.cluster_region
}

output "zones" {
  description = "List of zones in which the cluster resides"
  value       = local.cluster_zones
}

output "service_account" {
  description = "The service account to default running nodes as if not overridden in `node_pools`."
  value       = local.service_account
}

output "endpoint" {
  sensitive   = true
  description = "Cluster endpoint"
  value       = local.cluster_endpoint
  depends_on = [
    /* Nominally, the endpoint is populated as soon as it is known to Terraform.
    * However, the cluster may not be in a usable state yet.  Therefore any
    * resources dependent on the cluster being up will fail to deploy.  With
    * this explicit dependency, dependent resources can wait for the cluster
    * to be up.
    */
    google_container_cluster.primary,
    google_container_node_pool.pools,
  ]
}

output "min_master_version" {
  description = "Minimum master kubernetes version"
  value       = local.cluster_min_master_version
}

output "logging_service" {
  description = "Logging service used"
  value       = local.cluster_logging_service
}

output "monitoring_service" {
  description = "Monitoring service used"
  value       = local.cluster_monitoring_service
}

output "master_authorized_networks_config" {
  description = "Networks from which access to master is permitted"
  value       = google_container_cluster.primary.master_authorized_networks_config
}

output "master_version" {
  description = "Current master kubernetes version"
  value       = local.cluster_master_version
}

output "ca_certificate" {
  sensitive   = true
  description = "Cluster ca certificate (base64 encoded)"
  value       = local.cluster_ca_certificate
}

output "network_policy_enabled" {
  description = "Whether network policy enabled"
  value       = local.cluster_network_policy_enabled
}

output "http_load_balancing_enabled" {
  description = "Whether http load balancing enabled"
  value       = local.cluster_http_load_balancing_enabled
}

output "horizontal_pod_autoscaling_enabled" {
  description = "Whether horizontal pod autoscaling enabled"
  value       = local.cluster_horizontal_pod_autoscaling_enabled
}

output "node_pools_names" {
  description = "List of node pools names"
  value       = local.cluster_node_pools_names
}

output "node_pools_versions" {
  description = "List of node pools versions"
  value       = local.cluster_node_pools_versions
}

output "release_channel" {
  description = "The release channel of this cluster"
  value       = var.release_channel
}

output "identity_namespace" {
  description = "Workload Identity namespace"
  value       = length(local.cluster_workload_identity_config) > 0 ? local.cluster_workload_identity_config[0].identity_namespace : null
  depends_on = [
    google_container_cluster.primary
  ]
}

output "master_ipv4_cidr_block" {
  description = "The IP range in CIDR notation used for the hosted master network"
  value       = var.master_ipv4_cidr_block
}

output "peering_name" {
  description = "The name of the peering between this cluster and the Google owned VPC."
  value       = local.cluster_peering_name
}
