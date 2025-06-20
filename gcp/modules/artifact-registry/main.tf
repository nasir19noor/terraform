resource "google_artifact_registry_repository" "repository" {
  location      = var.location
  repository_id = var.repository_id
  description   = var.description
  format        = var.format

  # Optional: Add labels if provided
  dynamic "labels" {
    for_each = var.labels != null ? [var.labels] : []
    content {
      for k, v in labels.value : k => v
    }
  }

  # Optional: Configure cleanup policies if provided
  dynamic "cleanup_policies" {
    for_each = var.cleanup_policies
    content {
      id     = cleanup_policies.value.id
      action = cleanup_policies.value.action
      
      dynamic "condition" {
        for_each = cleanup_policies.value.condition != null ? [cleanup_policies.value.condition] : []
        content {
          tag_state             = lookup(condition.value, "tag_state", null)
          tag_prefixes          = lookup(condition.value, "tag_prefixes", null)
          version_name_prefixes = lookup(condition.value, "version_name_prefixes", null)
          package_name_prefixes = lookup(condition.value, "package_name_prefixes", null)
          older_than           = lookup(condition.value, "older_than", null)
          newer_than           = lookup(condition.value, "newer_than", null)
        }
      }

      dynamic "most_recent_versions" {
        for_each = cleanup_policies.value.most_recent_versions != null ? [cleanup_policies.value.most_recent_versions] : []
        content {
          package_name_prefixes = lookup(most_recent_versions.value, "package_name_prefixes", null)
          keep_count           = lookup(most_recent_versions.value, "keep_count", null)
        }
      }
    }
  }

  # Optional: Configure docker config if format is DOCKER
  dynamic "docker_config" {
    for_each = var.format == "DOCKER" && var.docker_config != null ? [var.docker_config] : []
    content {
      immutable_tags = lookup(docker_config.value, "immutable_tags", null)
    }
  }

  # Optional: Configure maven config if format is MAVEN
  dynamic "maven_config" {
    for_each = var.format == "MAVEN" && var.maven_config != null ? [var.maven_config] : []
    content {
      allow_snapshot_overwrites = lookup(maven_config.value, "allow_snapshot_overwrites", null)
      version_policy           = lookup(maven_config.value, "version_policy", null)
    }
  }

  project = var.project_id
}