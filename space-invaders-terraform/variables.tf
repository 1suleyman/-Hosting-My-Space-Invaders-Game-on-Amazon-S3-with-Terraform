# Input variables (bucket name, region, game file path)

variable "aws_region" {
  description = "The AWS region to deploy resources in"
  type        = string
  default     = "eu-west-2"
}

variable "bucket_name" {
  description = "The S3 bucket name for the Space Invaders game"
  type        = string
}

variable "game_file_path" {
  description = "The local path to the Space Invaders game files"
  type        = string
  default     = "game"
}
