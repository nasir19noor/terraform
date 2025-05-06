locals {
  config                  = yamldecode(file("../config.yaml"))
  region                  = local.config.global.region
  bucket                  = local.config.global.state_bucket
  name                    = local.config.s3.name

}    