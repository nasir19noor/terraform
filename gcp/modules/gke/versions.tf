# ---------------------------------------------------------------------------------------------------------------------
# This module is now only being tested with Terraform 1.0.x. However, to make upgrading easier, we are setting
# 0.13 as the minimum version, as that version added support for required_providers with source URLs, making it
# forwards compatible with 4.7.0 code.
# ---------------------------------------------------------------------------------------------------------------------


terraform {
  required_version = ">=0.13"

  required_providers {
    google = {
      source  = "hashicorp/google"
      version = ">= 4.7.0, < 5.0"
    }
  }
}

# terraform {
#   required_providers {
#     google = {
#       source = "hashicorp/google"
#       version = "3.22.0"
#     }
#   }
# }