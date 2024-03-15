terraform {
  backend "s3" {
    bucket         = "karna-test-s3-3-15-2024"       # s3 must create first 
    key            = "global/s3/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "terraform_state_lock"
    encrypt        = true
  }
}
