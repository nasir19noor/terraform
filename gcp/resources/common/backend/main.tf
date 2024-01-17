resource "google_storage_bucket" "backend" {
  project       = var.project_id
  name          = "nasir-terraform-state-wo-modules"
  location      = "ASIA"
  storage_class = "STANDARD"

  uniform_bucket_level_access = true
}