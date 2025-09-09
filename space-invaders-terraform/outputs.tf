# Outputs (bucket name, website URL)

output "bucket_name" {
  value = aws_s3_bucket.space_invaders.bucket
}

output "website_url" {
  value = aws_s3_bucket_website_configuration.space_invaders.website_endpoint
}
