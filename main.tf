
resource "aws_s3_bucket" "website" {
  bucket = "s3-Maelle-first"
  force_destroy = true
}

resource "aws_s3_bucket_policy" "policy" {
  bucket = aws_s3_bucket.website.bucket
  policy = file("policy.json")
}

resource "aws_s3_object" "index" {
  bucket = aws_s3_bucket.website.bucket
  key    = "index.html"
  source = "index.html"
  etag = filemd5("index.html")
}

resource "aws_s3_bucket_website_configuration" "website-config" {
  bucket = aws_s3_bucket.website.bucket

  index_document {
    suffix = "index.html" /// point d'entrée du site web
  }
}

resource "aws_s3_bucket_acl" "example_bucket_acl" {
  bucket = aws_s3_bucket.website.bucket
  acl    = "public-read"
}
