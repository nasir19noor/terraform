variable "project_id" {
  description = "The GCP project ID where the Artifact Registry repository will be created"
  type        = string
}

variable "location" {
  description = "The location/region where the repository will be created"
  type        = string
  default     = "us-central1"
  
  validation {
    condition = can(regex("^[a-z0-9-]+$", var.location))
    error_message = "Location must be a valid GCP region or zone name."
  }
}

variable "repository_id" {
  description = "The repository ID (name) for the Artifact Registry repository"
  type        = string
  
  validation {
    condition     = can(regex("^[a-z0-9-]+$", var.repository_id)) && length(var.repository_id) >= 1 && length(var.repository_id) <= 63
    error_message = "Repository ID must be 1-63 characters, contain only lowercase letters, numbers, and hyphens."
  }
}

variable "description" {
  description = "Description of the repository"
  type        = string
  default     = "Artifact Registry repository managed by Terraform"
}

variable "format" {
  description = "The format of packages that are stored in the repository"
  type        = string
  default     = "DOCKER"
  
  validation {
    condition = contains([
      "DOCKER",
      "MAVEN",
      "NPM",
      "PYTHON",
      "APT",
      "YUM",
      "GOOGET",
      "GO",
      "KFP",
      "GENERIC"
    ], var.format)
    error_message = "Format must be one of: DOCKER, MAVEN, NPM, PYTHON, APT, YUM, GOOGET, GO, KFP, GENERIC."
  }
}

variable "labels" {
  description = "Labels to be applied to the repository"
  type        = map(string)
  default     = null
}

variable "cleanup_policies" {
  description = "List of cleanup policies for the repository"
  type = list(object({
    id     = string
    action = string
    condition = optional(object({
      tag_state             = optional(string)
      tag_prefixes          = optional(list(string))
      version_name_prefixes = optional(list(string))
      package_name_prefixes = optional(list(string))
      older_than           = optional(string)
      newer_than           = optional(string)
    }))
    most_recent_versions = optional(object({
      package_name_prefixes = optional(list(string))
      keep_count           = optional(number)
    }))
  }))
  default = []
}

variable "docker_config" {
  description = "Docker-specific configuration for the repository (only applicable when format is DOCKER)"
  type = object({
    immutable_tags = optional(bool)
  })
  default = null
}

variable "maven_config" {
  description = "Maven-specific configuration for the repository (only applicable when format is MAVEN)"
  type = object({
    allow_snapshot_overwrites = optional(bool)
    version_policy           = optional(string)
  })
  default = null
}