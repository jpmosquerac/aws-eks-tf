provider "aws" {
  region = var.aws_region
}

locals {
  s3_iam_policy_prefix       = "s3-bucket-${var.s3_bucket_name}"
  dynamodb_iam_policy_prefix = "dynamodb-${var.dynamodb_table_name}"
}