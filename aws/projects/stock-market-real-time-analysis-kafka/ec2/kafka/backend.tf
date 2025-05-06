terraform {
  backend "s3" {
    key = "ec2/kafka/terraform.state"
  }
}