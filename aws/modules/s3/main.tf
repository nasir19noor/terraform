resource "aws_s3_bucket" "this" {
  bucket        = var.bucket
  # bucket_prefix = var.bucket_prefix

  force_destroy       = var.force_destroy
  object_lock_enabled = var.object_lock_enabled
  tags                = var.tags
}

resource "aws_s3_bucket_public_access_block" "this" {
  bucket = aws_s3_bucket.this.id

  block_public_acls       = var.block_public_acls
  block_public_policy     = var.block_public_policy
  ignore_public_acls      = var.ignore_public_acls
  restrict_public_buckets = var.restrict_public_buckets
}

resource "aws_s3_bucket_ownership_controls" "public_access_controls" {
  # This resource is only created if public read access is enabled
  count  = var.enable_public_read_access ? 1 : 0
  bucket = aws_s3_bucket.this.id
  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}

resource "aws_s3_bucket_acl" "public_read_acl" {
  # This resource is only created if public read access is enabled
  count      = var.enable_public_read_access ? 1 : 0
  depends_on = [aws_s3_bucket_ownership_controls.public_access_controls]
  bucket     = aws_s3_bucket.this.id
  acl        = "public-read"
}

resource "aws_s3_bucket_policy" "public_read_policy" {
  # This resource is only created if public read access is enabled
  count  = var.enable_public_read_access ? 1 : 0
  bucket = aws_s3_bucket.this.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid       = "PublicReadGetObject"
        Effect    = "Allow"
        Principal = "*"
        Action    = "s3:GetObject"
        Resource  = "${aws_s3_bucket.this.arn}/*"
      },
    ]
  })
}

resource "aws_s3_bucket_website_configuration" "website" {
  # This resource is only created if website hosting is enabled
  count  = var.enable_website_hosting ? 1 : 0
  bucket = aws_s3_bucket.this.id

  index_document {
    suffix = var.index_document
  }

  error_document {
    key = var.error_document
  }
  
  depends_on = [ aws_s3_bucket_policy.public_read_policy ]
}

