variable "aws_account" {
  description = "the AWS account id"
}

variable "aws_region" {
  description = "the AWS region"
}

variable "aws_environment" {
  description = "the AWS environment"
}

variable "s3_bucket_name" {
  description = "the name of the S3 bucket which will be used to store state files"
}

variable "dynamodb_table_name" {
  description = "the name of the DynamoDB table which will be used for state locking"
}

variable "dynamodb_read_capacity_units" {
  description = "the amount of read capacity units for the DynamoDB table"
}

variable "dynamodb_write_capacity_units" {
  description = "the amount of write capacity units for the DynamoDB table"
}

variable "iam_group_name_rw_access" {
  description = "the name of the IAM group that will have read-write access"
}

variable "iam_group_name_ro_access" {
  description = "the name of the IAM group that will have read-only access"
}