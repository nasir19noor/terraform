resource "aws_route53_resolver_endpoint" "surbana" {
  name      = "Surbana Jurong"
  direction = "INBOUND"

  security_group_ids = ["sg-02b8d78a399a27149"]

  ip_address {
    subnet_id = "subnet-0eed122751ceb5d7a"
    ip        = "10.100.1.100"
  }
  
  ip_address {
    subnet_id = "subnet-0eed122751ceb5d7a"
    ip        = "10.100.1.200"
  }


  protocols = ["Do53", "DoH"]

  tags = {
    Environment = "Surbana Jurong"
  }
}