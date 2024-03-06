terraform {
  backend "s3" {
    bucket         = "nasir-terraform-state"
    key            = "project/ollion/waf/terraform.tfstate"
    region         = "ap-southeast-1"
  }
}