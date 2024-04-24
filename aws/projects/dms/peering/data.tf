data "terraform_remote_state" "source" {
  backend = "s3"
  config = {
    bucket = "sj-dms-poc"
    key    = "source/networking/vpc/terraform.tfstate"
    region = "ap-southeast-1"
  }
}

data "terraform_remote_state" "target" {
  backend = "s3"
  config = {
    bucket = "sj-dms-poc"
    key    = "target/networking/vpc/terraform.tfstate"
    region = "ap-southeast-1"
  }
}

