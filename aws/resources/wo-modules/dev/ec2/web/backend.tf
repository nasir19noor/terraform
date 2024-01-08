terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "~> 5.21.0"
    }
  }

  backend "s3" {
    bucket         = "nasir-terraform-wo-module"
    key            = "dev/compute/ec2/web/terraform.tfstate"
    region         = "ap-southeast-1"
  }
}