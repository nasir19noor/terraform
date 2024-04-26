data "terraform_remote_state" "vpc" {
  backend = "s3"
  config = {
    bucket = "sj-dms-poc"
    key    = "source/networking/vpc/terraform.tfstate"
    region = "ap-southeast-1"
  }
}

