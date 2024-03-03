Lab-1: How to create IAM Users and Groups using Terraform ?
---------------------------------------------------------------------------------
providers.tf
-------------------
```
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}
# Configure the AWS Provider
provider "aws" {
  region = "us-east-1"
  # access_key = "AKIAUNKMGRYLZG6RTUPM"
  # secret_key = "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"  
}
```
main.tf
-------------------
```# create user Shiva
resource "aws_iam_user" "shiva" {    
  name = "shiva"                    
}
```
```# create bulk users defined
resource "aws_iam_user" "New-users-2024" {
  name = var.new-users[count.index]
  count = length(var.new-users)
}
```
```# create group Developers and shiv user to that group and add policy
resource "aws_iam_group" "Developers" {
  name = "Developers" 
}
resource "aws_iam_group_policy" "Dev-group-policy" {
  group = aws_iam_group.Developers.name
  policy = file("Dev-group-policy.json")
}

resource "aws_iam_user" "shiva" {
  name = "shiva"
}
resource "aws_iam_user_group_membership" "Dev-group" {
  user = aws_iam_user.shiva.name
  groups = [ aws_iam_group_policy.Dev-group-policy.group ]
}
```
variables.tf
-------------------
```
variable "new-users" {
  default = ["Rama", "Seetha", "Hanuma"]
  type = list(string)
}
```

