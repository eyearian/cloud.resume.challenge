module "tfstate" {
  source = "../modules/s3"

  bucket_name = var.bucket_name
  acl = "private"
}

module "static_bucket" {
  source = "../modules/s3_static"

  bucket_name = "ey-resume"
  acl = "public-read"
}

module "cloudfront" {
  source = "../modules/cloudfront"

  domain_name = module.static_bucket.domain_name
  acm_certificate_arn = module.acm_cert.acm_certificate_arn
}

module "acm_cert" {
  source = "../modules/acm"

  providers = {
    aws.acm = aws.acm
   }
}