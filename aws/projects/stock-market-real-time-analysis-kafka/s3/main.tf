module "s3" {
  source   = "./../../../modules/s3"
  bucket   = local.name

  tags = {
    "Name" = local.name
  }
}

