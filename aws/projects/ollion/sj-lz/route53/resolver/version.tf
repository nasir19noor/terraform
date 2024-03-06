terraform {
  required_version = ">= 0.12"

  backend "s3" {
    key = "ollion/route53/resolver/terraform.tfstate"
	region = "ap-southeast-1"
  }
}