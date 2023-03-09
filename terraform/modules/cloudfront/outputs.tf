output "cloudfront_id" {
  value = aws_cloudfront_distribution.this.domain_name
}

output "cloudfront_zone" {
  value = aws_cloudfront_distribution.this.hosted_zone_id
}