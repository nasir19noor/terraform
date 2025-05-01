terraform {
  backend "s3" {
    key = "subnet/terraform.state"
    # region = local.region
  }
}