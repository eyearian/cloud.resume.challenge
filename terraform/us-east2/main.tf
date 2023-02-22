module "tfstate" {
  source = "../modules/s3"

  name = var.bucket
  acl = "private"
}

module "static_bucket" {
  source = "../modules/s3_static"

  name = var.bucket
  acl = "public-read"
}