data "aws_route53_zone" "website" {
  name = "ericyearian.com"
}

resource "aws_route53_record" "www" {
  zone_id = data.aws_route53_zone.website.zone_id
  name = "ericyearian.com"
  type = "A"

  alias {
    name = var.cloudfront_id
    zone_id = var.cloudfront_zone
    evaluate_target_health = false
  }
}