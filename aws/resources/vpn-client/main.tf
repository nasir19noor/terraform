resource "aws_ec2_client_vpn_endpoint" "rpp" {
  description            = "${var.name}-Client-VPN"
  server_certificate_arn = aws_acm_certificate.server.arn
  client_cidr_block      = var.cidr
  split_tunnel           = var.split_tunnel
  dns_servers            = var.dns_servers
  self_service_portal    = local.self_service_portal
  security_group_ids     = [aws_security_group.client_vpn_sg.id]
  vpc_id                 = data.terraform_remote_state.prod_networking_vpc.outputs.vpc_id

  authentication_options {
    type                       = var.authentication_type
    root_certificate_chain_arn = var.authentication_type != "certificate-authentication" ? null : aws_acm_certificate.root.arn
    //saml_provider_arn          = var.authentication_saml_provider_arn
  }

  connection_log_options {
    enabled               = true
    cloudwatch_log_group  = aws_cloudwatch_log_group.vpn.name
    cloudwatch_log_stream = aws_cloudwatch_log_stream.vpn.name
  }
}

resource "aws_ec2_client_vpn_network_association" "client_vpn_association_private" {
  client_vpn_endpoint_id = aws_ec2_client_vpn_endpoint.rpp.id
  subnet_id              = data.terraform_remote_state.prod_networking_vpc.outputs.app_subnet_ids[0]
}

resource "aws_ec2_client_vpn_network_association" "client_vpn_association_public" {
  client_vpn_endpoint_id = aws_ec2_client_vpn_endpoint.rpp.id
  subnet_id              = data.terraform_remote_state.prod_networking_vpc.outputs.vpn_subnet_ids[0]
}

resource "aws_ec2_client_vpn_authorization_rule" "authorization_rule" {
  client_vpn_endpoint_id = aws_ec2_client_vpn_endpoint.rpp.id
  
  target_network_cidr    = var.allowed_cidr_ranges
  authorize_all_groups   = true
}