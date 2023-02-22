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