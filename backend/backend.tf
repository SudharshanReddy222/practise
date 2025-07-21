terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }
}

# Configure the AWS Provider
provider "aws" {
  region = "us-east-1"
}
 resource "aws_s3_bucket" "my_bucket" {
  bucket = "terraform-state-bucket-93474676"
  lifecycle {
    prevent_destroy = true
  }

  tags = {
    Name        = "MyBucket"
    Environment = "Dev"
  }
 }
 resource "aws_dynamodb_table" "terraform_state_lock" {
  name         = "terraform_state_lock"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }

  tags = {
    Name        = "TerraformStateLock"
    Environment = "Dev"
  }
 }