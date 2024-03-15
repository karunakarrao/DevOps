provider "aws" {
  region = var.vpc.aws_region
}

#  create and  S3  bucket 
resource "aws_s3_bucket" "s3_bucket_1" {
  bucket = "karna-test-s3-3-15-2024"
}

# create Dynamo-DB for state locking
resource "aws_dynamodb_table" "terraform_state_lock" {
  name         = "terraform_state_lock"
  hash_key     = "LockID"
  billing_mode = "PAY_PER_REQUEST"
  attribute {
    name = "LockID"
    type = "S"
  }
}


