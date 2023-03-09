# data "aws_route53_zone" "website" {
# }

resource "aws_route53_zone" "website" {
  name = "ericyearian.com"
}

# resource "aws_route53_record" "www" {
#   zone_id = aws_route53_zone.website.zone_id
#   name = "ericyearian.com"
#   type = "NS"
#   ttl = 5
#   records = aws_route53_zone.website.name_servers
# }