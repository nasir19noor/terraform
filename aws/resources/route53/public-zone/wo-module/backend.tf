terraform {
  backend "s3" {
    bucket         = "nasir-terraform-state"
    key            = "route53/public-zone/wo-module/terraform.tfstate"
    region         = "ap-southeast-1"
  }
}