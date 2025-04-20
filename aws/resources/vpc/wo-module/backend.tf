terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "~> 5.21.0"
    }
  }

  backend "s3" {
    bucket         = "terraform.nasir.id"
    key            = "vpc/wo-module/terraform.tfstate"
    region         = "ap-southeast-1"
  }
}