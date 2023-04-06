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

module "r53" {
  source = "../modules/route53"

  cloudfront_id = module.cloudfront.cloudfront_id
  cloudfront_zone = module.cloudfront.cloudfront_zone
}

module "website_table" {
  source = "../modules/dynamo"

  table_name = "visit_count"
}

module "apigateway" {
  source = "../modules/apigateway"

  apigateway_name = "dynamo_lambda_api"
  invoke_arn = module.lambda.invoke_arn
  function_name = module.lambda.function_name
}

module "lambda" {
  source = "../modules/lambda"
}