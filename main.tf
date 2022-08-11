provider "aws" {
  region = "eu-west-2"
}

resource "aws_s3_bucket_versioning" "terraform_state" {
  bucket = "meeday-terraform-env0-example"

  versioning_configuration {
    status = "Enabled"
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

resource "aws_s3_bucket" "test" {
  bucket = "s3-test-meeday"

}


terraform {
  backend "s3" {
    # Replace this with your bucket name!
    bucket = "meeday-terraform-env0-example"
    key    = "env0-state/terraform.tfstate"
    region = "eu-west-2"
    # Replace this with your DynamoDB table name!
    dynamodb_table = "terraform-env0-locks"
    encrypt        = true
  }
}
