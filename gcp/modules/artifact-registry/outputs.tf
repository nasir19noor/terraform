# Outputs the full name of the created Artifact Registry repository.
output "repository_name" {
  description = "The name of the Artifact Registry repository."
  value       = google_artifact_registry_repository.this.name
}

# Outputs the location of the created repository.
output "repository_location" {
  description = "The location of the Artifact Registry repository."
  value       = google_artifact_registry_repository.this.location
}

# Outputs the repository ID.
output "repository_id" {
  description = "The ID of the Artifact Registry repository."
  value       = google_artifact_registry_repository.this.repository_id
}

# Outputs the unique identifier of the repository.
output "repository_full_id" {
  description = "The full identifier of the Artifact Registry repository."
  value       = google_artifact_registry_repository.this.id
}