data "terraform_remote_state" "vpc_id" {
  backend = "s3" 
  config = {
    bucket = local.bucket
    key = "vpc/terraform.tfstate" 
    region = local.region
  }
}

data "terraform_remote_state" "vpc_cidr_block" {
  backend = "s3" 
  config = {
    bucket = local.bucket
    key = "vpc/terraform.tfstate" 
    region = local.region
  }
}