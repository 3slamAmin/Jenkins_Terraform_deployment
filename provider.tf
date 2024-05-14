provider "aws" {
  region = "us-east-1"
}

terraform {
  backend "s3" {
    bucket = "statefile-eskam-storage"
    dynamodb_table = "terraform-state-lock-dynamo"
    key    = "statefile"
    region = "us-east-1"
  }
}
