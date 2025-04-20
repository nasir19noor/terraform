module "gke" {
  source = "../../modules/gke"

  name                     = var.name
  project_id               = var.project_id
  region                   = var.region
  description              = var.description
  network                  = var.network
  subnetwork               = var.subnetwork
  network_project_id       = var.network_project_id
  kubernetes_version       = var.kubernetes_version
  enable_l4_ilb_subsetting = true
  datapath_provider        = var.datapath_provider
  networking_mode          = var.networking_mode
  ip_range_pods            = var.ip_range_pods
  ip_range_services        = var.ip_range_services
  master_ipv4_cidr_block   = var.master_ipv4_cidr_block
  regional                 = var.regional
  zones                    = var.zones
  deletion_protection      = var.deletion_protection
  enable_private_nodes     = var.enable_private_nodes
  enable_private_endpoint  = true
  service_account          = google_service_account.gke_sa.email
  remove_default_node_pool = var.remove_default_node_pool

  node_pools = [
    {
      name               = var.node_pool_name
      machine_type       = var.machine_type
      image_type         = var.image_type
      local_ssd_count    = var.local_ssd_count
      disk_size_gb       = var.disk_size_gb
      disk_type          = var.disk_type
      preemptible        = var.preemptible
      node_locations     = var.node_locations
      autoscaling        = var.autoscaling
      min_count          = var.min_count
      max_count          = var.max_count
      initial_node_count = var.initial_node_count
      max_pods_per_node  = var.max_pods_per_node
      node_metadata      = var.node_metadata
      auto_repair        = true
      auto_upgrade       = true
    }
  ]

  master_authorized_networks_cidr_blocks = [
    {
      cidr_block   = "10.21.15.0/24"
      display_name = "workload"
    }
  ]
  node_pools_tags = {
    all = ["gke"]
  }

  
    node_pools_metadata = {
      all = {node-pool-metadata-custom-value = var.name}
    }
}

resource "google_service_account" "gke_sa" {
  account_id   = "${var.name}-sa"
  display_name = "GKE Service Account for ${var.name}"
  project      = var.project_id
}

# Grant the service account the required roles
resource "google_project_iam_member" "gke_sa_roles" {
  for_each = toset([
    "roles/container.admin",
    "roles/container.clusterAdmin",
    "roles/compute.admin",
    "roles/storage.objectUser",
    "roles/container.nodeServiceAccount",
    "roles/logging.logWriter",
    "roles/monitoring.metricWriter",
    "roles/monitoring.viewer",
    "roles/stackdriver.resourceMetadata.writer",
    "roles/storage.objectViewer",
    "roles/artifactregistry.reader"
  ])

  project = var.project_id
  role    = each.key
  member  = "serviceAccount:${google_service_account.gke_sa.email}"
}
