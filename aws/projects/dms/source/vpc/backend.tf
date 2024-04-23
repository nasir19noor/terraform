terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "~> 5.21.0"
    }
  }

  backend "s3" {
    bucket         = "sj-dms-poc"
    key            = "source/networking/vpc/terraform.tfstate"
    region         = "ap-southeast-1"
  }
}