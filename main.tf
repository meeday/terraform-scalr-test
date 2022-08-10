provider "aws" {
  region = "eu-west-2"
}

resource "aws_s3_bucket" "terraform_state" {
  bucket = "terraform-env0-test"
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

resource "aws_dynamodb_table" "terraform_locks" {
  name         = "terraform-env0-locks"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "LockID"
  attribute {
    name = "LockID"
    type = "S"
  }
}


terraform {
  backend "s3" {
    # Replace this with your bucket name!
    bucket = "terraform-env0-test"
    key    = "global/s3/terraform.tfstate"
    region = "eu-west-2"
    # Replace this with your DynamoDB table name!
    dynamodb_table = "terraform-env0-locks"
    encrypt        = true
  }
}
