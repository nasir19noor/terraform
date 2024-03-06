terraform {
  backend "s3" {
    bucket         = "terraform.nasir.id"
    key            = "project/ollion/route53/resolver/terraform.tfstate"
    region         = "ap-southeast-1"
  }
}