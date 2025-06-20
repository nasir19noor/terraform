# Google Artifact Registry Repository Terraform Module

This Terraform module creates a Google Cloud Artifact Registry repository with configurable options for different package formats and cleanup policies.

## Features

- Support for multiple package formats (Docker, Maven, NPM, Python, etc.)
- Configurable cleanup policies
- Optional Docker and Maven specific configurations
- Comprehensive input validation
- Rich output values for integration with other modules

## Usage

### Basic Example

```hcl
module "artifact_registry" {
  source = "./path/to/this/module"
  
  project_id    = "my-gcp-project"
  location      = "us-central1"
  repository_id = "my-docker-repo"
  description   = "Docker repository for my application"
  format        = "DOCKER"
}
```

### Advanced Example with Cleanup Policies

```hcl
module "artifact_registry" {
  source = "./path/to/this/module"
  
  project_id    = "my-gcp-project"
  location      = "us-central1"
  repository_id = "my-docker-repo"
  description   = "Docker repository with cleanup policies"
  format        = "DOCKER"
  
  labels = {
    environment = "production"
    team        = "platform"
    managed-by  = "terraform"
  }
  
  cleanup_policies = [
    {
      id     = "delete-old-images"
      action = "DELETE"
      condition = {
        older_than = "2592000s"  # 30 days
      }
    },
    {
      id     = "keep-recent-versions"
      action = "KEEP"
      most_recent_versions = {
        keep_count = 10
      }
    }
  ]
  
  docker_config = {
    immutable_tags = true
  }
}
```

### Maven Repository Example

```hcl
module "maven_registry" {
  source = "./path/to/this/module"
  
  project_id    = "my-gcp-project"
  location      = "us-central1"
  repository_id = "my-maven-repo"
  description   = "Maven repository for Java artifacts"
  format        = "MAVEN"
  
  maven_config = {
    allow_snapshot_overwrites = true
    version_policy           = "VERSION_POLICY_UNSPECIFIED"
  }
}
```

## Requirements

| Name | Version |
|------|---------|
| terraform | >= 1.0 |
| google | >= 4.84.0, < 6.0.0 |

## Providers

| Name | Version |
|------|---------|
| google | >= 4.84.0, < 6.0.0 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| project_id | The GCP project ID where the Artifact Registry repository will be created | `string` | n/a | yes |
| location | The location/region where the repository will be created | `string` | `"us-central1"` | no |
| repository_id | The repository ID (name) for the Artifact Registry repository | `string` | n/a | yes |
| description | Description of the repository | `string` | `"Artifact Registry repository managed by Terraform"` | no |
| format | The format of packages that are stored in the repository | `string` | `"DOCKER"` | no |
| labels | Labels to be applied to the repository | `map(string)` | `null` | no |
| cleanup_policies | List of cleanup policies for the repository | `list(object)` | `[]` | no |
| docker_config | Docker-specific configuration for the repository | `object` | `null` | no |
| maven_config | Maven-specific configuration for the repository | `object` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| repository_id | The ID of the created Artifact Registry repository |
| name | The name of the repository in the format projects/{project}/locations/{location}/repositories/{repository_id} |
| location | The location where the repository is hosted |
| format | The format of packages that are stored in the repository |
| description | The description of the repository |
| create_time | The time when the repository was created |
| update_time | The time when the repository was last updated |
| project | The project ID where the repository is located |
| registry_url | The URL that can be used to access the repository |
| labels | Labels applied to the repository |

## Supported Package Formats

- `DOCKER` - Docker images
- `MAVEN` - Maven artifacts
- `NPM` - Node.js packages
- `PYTHON` - Python packages
- `APT` - Debian packages
- `YUM` - RPM packages
- `GOOGET` - Google packages
- `GO` - Go modules
- `KFP` - Kubeflow Pipelines
- `GENERIC` - Generic artifacts

## Notes

- The module includes input validation for repository ID format and supported package formats
- Cleanup policies help manage storage costs by automatically removing old or unused artifacts
- Docker and Maven specific configurations are only applied when the respective format is selected
- The `registry_url` output provides a ready-to-use URL for Docker operations

## License

This module is released under the MIT License.