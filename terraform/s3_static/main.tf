resource "aws_s3_bucket" "this" {
  bucket = var.name
  acl = var.acl
}

resource "aws_s3_bucket_website_configuration" "this" {
  bucket = aws_s3_bucket.this.id

  index_document {
    suffix = "index.html"
  }
}