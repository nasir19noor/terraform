resource "google_artifact_registry_repository" "this" {
  location      = var.region
  project       = var.project_id
  repository_id = var.name
  description   = var.description
  format        = var.format
}