terraform {
  backend "s3" {
    bucket         = "terraform.nasir.id"
    key            = "route53/w-module/terraform.tfstate"
    region         = "ap-southeast-1"
  }
}