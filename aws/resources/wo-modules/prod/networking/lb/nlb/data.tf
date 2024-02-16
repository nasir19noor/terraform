data "terraform_remote_state" "vpc" {
  backend = "s3"
  config = {
    bucket = "nasir-terraform-wo-module"
    key    = "prod/networking/vpc/terraform.tfstate"
    region = "ap-southeast-1"
  }
}

data "terraform_remote_state" "ec2" {
  backend = "s3"
  config = {
    bucket = "nasir-terraform-wo-module"
    key    = "prod/ec2/be/terraform.tfstate"
    region = "ap-southeast-1"
  }
}


