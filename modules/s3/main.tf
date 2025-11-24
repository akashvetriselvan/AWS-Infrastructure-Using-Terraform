# Random suffix for uniqueness
resource "random_id" "rand" {
  byte_length = 4
}

# Create the S3 bucket (modern configuration, no ACLs)
resource "aws_s3_bucket" "my_bucket" {
  bucket = "${var.s3_bucket_name}-${random_id.rand.hex}"

  tags = {
    Name = "${var.project}-s3"
  }
}

# Disable ACLs (Bucket owner enforced)
resource "aws_s3_bucket_ownership_controls" "example" {
  bucket = aws_s3_bucket.my_bucket.id

  rule {
    object_ownership = "BucketOwnerEnforced"
  }
}

# Block all public access for safety
resource "aws_s3_bucket_public_access_block" "block" {
  bucket                  = aws_s3_bucket.my_bucket.id
  block_public_acls        = true
  block_public_policy      = true
  ignore_public_acls       = true
  restrict_public_buckets  = true
}

variable "project" {
  description = "Project name for tagging and table naming"
}
