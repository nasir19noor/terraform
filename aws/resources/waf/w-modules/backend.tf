terraform {
  backend "s3" {
    bucket         = "nasir-terraform-state"
    key            = "waf/w-module/terraform.tfstate"
    region         = "ap-southeast-1"
  }
}