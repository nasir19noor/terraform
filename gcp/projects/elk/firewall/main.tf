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

module "firewall-9200" {
  source = "../../../modules/firewall"

  project       = local.project_id
  name          = "nasir-elk-allow-9200"
  network       = local.network
  description   = "allow 9200 for elasticsearch"
  protocol      = local.ssh_protocol
  ports         = ["9200"]
  source_ranges = local.ssh_source_ranges
  target_tags   = local.ssh_target_tags
}

module "firewall-80" {
  source = "../../../modules/firewall"

  project       = local.project_id
  name          = "nasir-elk-allow-80"
  network       = local.network
  description   = "allow 80"
  protocol      = local.ssh_protocol
  ports         = ["80"]
  source_ranges = local.ssh_source_ranges
  target_tags   = local.ssh_target_tags
}

module "firewall-443" {
  source = "../../../modules/firewall"

  project       = local.project_id
  name          = "nasir-elk-allow-443"
  network       = local.network
  description   = "allow 443"
  protocol      = local.ssh_protocol
  ports         = ["443"]
  source_ranges = local.ssh_source_ranges
  target_tags   = local.ssh_target_tags
}

module "firewall-5601" {
  source = "../../../modules/firewall"

  project       = local.project_id
  name          = "nasir-elk-allow-5601"
  network       = local.network
  description   = "allow 5601"
  protocol      = local.ssh_protocol
  ports         = ["5601"]
  source_ranges = local.ssh_source_ranges
  target_tags   = local.ssh_target_tags
}




