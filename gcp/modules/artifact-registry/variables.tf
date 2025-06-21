# Defines the Google Cloud Project ID where the resources will be created.
variable "project_id" {
  description = "The ID of the Google Cloud project."
  type        = string
}

# Defines the name for the Artifact Registry repository.
variable "name" {
  description = "The name of the Artifact Registry repository."
  type        = string
  default     = "my-artifact-repo"
}

# Defines the GCP region where the repository will be located.
variable "region" {
  description = "The Google Cloud region to deploy the repository to."
  type        = string
  default     = "us-central1"
}

# Defines the description for the repository.
variable "description" {
  description = "A brief description for the Artifact Registry repository."
  type        = string
  default     = "My Awesome Artifact Registry repository"
}

# Defines the format of the artifacts that the repository will store.
# Includes a validation block to ensure only supported formats are used.
variable "format" {
  description = "The format of the repository (e.g., DOCKER, MAVEN, NPM, PYTHON)."
  type        = string
  default     = "DOCKER"

  validation {
    condition     = contains(["DOCKER", "MAVEN", "NPM", "PYTHON", "APT", "YUM", "GO", "KFP"], upper(var.format))
    error_message = "The format must be one of the following: DOCKER, MAVEN, NPM, PYTHON, APT, YUM, GO, KFP."
  }
}

