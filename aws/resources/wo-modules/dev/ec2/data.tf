data "terraform_remote_state" "vpc" {
  backend = "s3"
  config = {
    bucket = "nasir-terraform-wo-module"
    key    = "networking/vpc/terraform.tfstate"
    region = "ap-southeast-1"
  }
}