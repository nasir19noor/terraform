terraform {
  backend "s3" {
    bucket         = "nasir-terraform-state"
    key            = "route53/w-module/terraform.tfstate"
    region         = "ap-southeast-1"
  }
}