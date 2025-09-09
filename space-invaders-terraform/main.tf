# Terraform configuration for S3 bucket and website hosting

provider "aws" {
  region = var.aws_region
}

# Define a local variable for the bucket name to avoid repetition.
locals {
  bucket_name = var.bucket_name
}

# 1. Create the S3 bucket.
resource "aws_s3_bucket" "space_invaders" {
# this will create the S3 bucket with the specified name
  bucket = local.bucket_name
}

# 2. Configure public access.
# This resource is required to unblock public access.
resource "aws_s3_bucket_public_access_block" "space_invaders" {
# this will allow public access to the bucket
  bucket = aws_s3_bucket.space_invaders.id

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

# 3. Apply a bucket policy for public read access.
# This is the modern, secure way to grant permissions to the bucket.
resource "aws_s3_bucket_policy" "space_invaders" {
# this will allow public read access to all objects in the bucket
  bucket = aws_s3_bucket.space_invaders.id
  policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Sid" : "PublicReadGetObject",
        "Effect" : "Allow",
        "Principal" : "*",
        "Action" : [
          "s3:GetObject"
        ],
        "Resource" : [
          "arn:aws:s3:::${local.bucket_name}/*"
        ]
      }
    ]
  })

# this ensures the policy is applied after the public access block is configured
  depends_on = [
    aws_s3_bucket_public_access_block.space_invaders
  ]
}

# 4. Configure static website hosting.
resource "aws_s3_bucket_website_configuration" "space_invaders" {
# this will set up the bucket to serve a static website
  bucket = aws_s3_bucket.space_invaders.id

  index_document {
    suffix = "index.html"
  }
}

# 5. Upload the game files.
resource "aws_s3_object" "game_files" {
# this will iterate over all files in the specified directory and upload them to the S3 bucket
  for_each = fileset("${path.module}/game", "**")

  bucket = aws_s3_bucket.space_invaders.id
  key    = each.value
  source = "${path.module}/game/${each.value}"
}
