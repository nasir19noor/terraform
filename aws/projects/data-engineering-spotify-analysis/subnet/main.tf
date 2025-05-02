module "subnets" {
  source = "./../../../modules/subnet"
  
  region        = local.region
  vpc_id        = local.vpc_id
  subnet_count  = local.subnet_count
  cidr_blocks   = local.cidr_blocks
  map_public_ip_on_launch = true
  tags = {
    Name        = "data-subnet"
    Environment = "dev"
  }
}