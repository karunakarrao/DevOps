provider "aws" {
  region = var.vpc.aws_region
}

terraform {
  backend "s3" {
    bucket         = "karna-test-s3-3-15-2024"       # s3 must create first 
    key            = "global/s3/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "terraform_state_lock"
    encrypt        = true
  }
}

#  First create and  S3  bucket before backend.
resource "aws_s3_bucket" "s3_bucket_1" {
  bucket = "karna-test-s3-3-15-2024"
}

# Frist create Dynamo-DB for state locking before backend.
resource "aws_dynamodb_table" "terraform_state_lock" {
  name         = "terraform_state_lock"
  hash_key     = "LockID"
  billing_mode = "PAY_PER_REQUEST"
  attribute {
    name = "LockID"
    type = "S"
  }
}





