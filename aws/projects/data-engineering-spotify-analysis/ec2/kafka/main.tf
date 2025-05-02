module "azure_agent" {
  source                      = "./../../../../modules/ec2"
  create                      = true
  instance_type               = local.instance_type
  ami                         = local.ami
  subnet_id                   = local.subnet_id
  vpc_security_group_ids      = [module.security_group_kafka.security_group_id]
  create_iam_instance_profile = true
  availability_zone           = local.availability_zone
  root_block_device = [
    {
      volume_size           = local.root_block_device_volume_size
      volume_type           = local.root_block_device_volume_type
      delete_on_termination = local.root_block_device_delete_on_termination
      encrypted             = local.root_block_device_encrypted 
    }
  ]

  iam_role_name            = "iam-role-kafka"
  iam_role_use_name_prefix = false
  iam_role_policies = {
    "AmazonSSMManagedInstanceCore" = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
    "AmazonEKSWorkerNodePolicy"    = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
  }

  metadata_options = {
    http_endpoint               = "enabled"
    http_tokens                 = "required"
    http_put_response_hop_limit = 1
    instance_metadata_tags      = null
  }

  tags = {
    "Name" = "kafka"
  }
}


module "security_group_kafka" {
  source = "./../../../../modules/security_group"

  security_group_name = "kafka-sg"
  description         = "Security group for kafka"
  vpc_id              = local.vpc_id
  ingress             = []
  egress = [
    {
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      cidr_blocks = ["0.0.0.0/0"]
      description = "Allow all outbound traffic"
    }
  ]
  revoke_rules_on_delete = true
}