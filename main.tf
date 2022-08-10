provider "aws" {
  access_key = var.AWS_ACCESS_KEY_ID
  secret_key = var.AWS_SECRET_ACCESS_KEY
  region     = "eu-west-2"
}

resource "aws_s3_bucket" "terraform_state" {
  bucket = "terraform-scalr-test"
  # Enable versioning so we can see the full revision history of our
  # state files
  versioning {
    enabled = true
  }
  # Enable server-side encryption by default
  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }
}
