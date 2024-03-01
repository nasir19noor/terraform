resource "aws_route53_zone" "private" {
  name = "private.nasir.id"

  vpc {
    vpc_id = "vpc-0734ed2d81043d90c"
  }
}