locals {
  config                  = yamldecode(file("../../config.yaml"))
  region                  = local.config.global.region
  bucket                  = local.config.global.state_bucket
  vpc_id                  = data.terraform_remote_state.vpc.outputs.vpc_id
  subnet_id               = data.terraform_remote_state.subnet.outputs.subnet_ids[0]
  instance_type           = local.config.ec2.kafka.instance_type
  ami                     = local.config.ec2.kafka.ami
  availability_zone       = data.terraform_remote_state.subnet.outputs.subnet_availability_zones[0]
  root_block_device_volume_size = local.config.ec2.kafka.root_block_device.volume_size
  root_block_device_volume_type = local.config.ec2.kafka.root_block_device.volume_type
  root_block_device_delete_on_termination = local.config.ec2.kafka.root_block_device.delete_on_termination
  root_block_device_encrypted = local.config.ec2.kafka.root_block_device.encrypted

}    