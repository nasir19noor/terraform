output "repository_id" {
  description = "The ID of the created Artifact Registry repository"
  value       = google_artifact_registry_repository.repository.repository_id
}

output "name" {
  description = "The name of the repository in the format projects/{project}/locations/{location}/repositories/{repository_id}"
  value       = google_artifact_registry_repository.repository.name
}

output "location" {
  description = "The location where the repository is hosted"
  value       = google_artifact_registry_repository.repository.location
}

output "format" {
  description = "The format of packages that are stored in the repository"
  value       = google_artifact_registry_repository.repository.format
}

output "description" {
  description = "The description of the repository"
  value       = google_artifact_registry_repository.repository.description
}

output "create_time" {
  description = "The time when the repository was created"
  value       = google_artifact_registry_repository.repository.create_time
}

output "update_time" {
  description = "The time when the repository was last updated"
  value       = google_artifact_registry_repository.repository.update_time
}

output "project" {
  description = "The project ID where the repository is located"
  value       = google_artifact_registry_repository.repository.project
}

output "registry_url" {
  description = "The URL that can be used to access the repository"
  value       = "${google_artifact_registry_repository.repository.location}-docker.pkg.dev/${google_artifact_registry_repository.repository.project}/${google_artifact_registry_repository.repository.repository_id}"
}

output "labels" {
  description = "Labels applied to the repository"
  value       = google_artifact_registry_repository.repository.labels
}