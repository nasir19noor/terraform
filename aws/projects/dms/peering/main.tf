resource "aws_vpc_peering_connection" "peer" {
  vpc_id        = data.terraform_remote_state.source.outputs.vpc_id
  peer_vpc_id   = data.terraform_remote_state.target.outputs.vpc_id
  //peer_owner_id = data.aws_caller_identity.peer.account_id
  peer_region   = "${var.region}"
  auto_accept   = false

  tags = {
    Side = "Requester"
    Name = "${var.project}"
  }
}

# Accepter's side of the connection.
resource "aws_vpc_peering_connection_accepter" "peer" {
 // provider                  = aws.peer
  vpc_peering_connection_id = aws_vpc_peering_connection.peer.id
  auto_accept               = true

  tags = {
    Side = "Accepter"
  }
}