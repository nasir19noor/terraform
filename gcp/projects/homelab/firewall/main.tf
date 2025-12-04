module "firewall-ssh" {
  source = "../../../modules/firewall"

  project       = local.project_id
  name          = local.ssh_name
  network       = local.network
  description   = local.ssh_description 
  protocol      = local.ssh_protocol
  ports         = local.ssh_ports
  source_ranges = local.ssh_source_ranges
  target_tags   = local.ssh_target_tags
}

module "firewall-allow-service" {
  source = "../../../modules/firewall"

  project       = local.project_id
  name          = "allow-service"
  network       = local.network
  description   = "allow service container port"
  protocol      = local.ssh_protocol
  ports         = ["30000-33000"]
  source_ranges = local.ssh_source_ranges
  target_tags   = local.ssh_target_tags
}


