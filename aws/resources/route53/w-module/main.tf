provider "aws" {
  region = "ap-southeast-1"
}

locals {
  zone_name = sort(keys(module.zones.route53_zone_zone_id))[0]
}

module "zones" {
  source = "../../modules/route53/zones"

  zones = {

    "aws.surbana.tech" = {
      # in case than private and public zones with the same domain name
      domain_name = "aws.surbana.tech"
      comment     = "aws.surbana.tech"
      vpc = [
        {
          vpc_id = "vpc-0734ed2d81043d90c"
        },
        {
          vpc_id = "vpc-0bea355e60250bc05"
        },
      ]
      tags = {
        Name = "aws.surbana.tech"
      }
    }
  }

  tags = {
    ManagedBy = "Terraform"
  }
}
