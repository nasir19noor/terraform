resource "aws_route53_zone" "cloudninja" {
  name = "cloudninja.site"
}

resource "aws_route53_record" "dev-a" {
  zone_id = aws_route53_zone.cloudninja.zone_id
  name    = "dev.cloudninja.site"
  type    = "A"
  ttl     = "30"
  records = ["125.4.21.34"]
}