variable "aws_region" {
  description = "the AWS region"
}

variable "aws_environment" {
  description = "the AWS environment"
}

variable "infra_folder" {
  description = "the folder where tf starts"
}

# ---------------------------------------------------------------------------
# backend
# ---------------------------------------------------------------------------

variable "s3_bucket_name" {
  description = "the name of the S3 bucket which will be used to store state files"
}

variable "dynamodb_table_name" {
  description = "the name of the DynamoDB table which will be used for state locking"
}

variable "dynamodb_read_capacity_units" {
  description = "the amount of read capacity units for the DynamoDB table"
  default     = 5
}

variable "dynamodb_write_capacity_units" {
  description = "the amount of write capacity units for the DynamoDB table"
  default     = 1
}

variable "iam_group_name_rw_access" {
  description = "the name of the IAM group that will have read-write access"
  default     = "terraform_rw_access"
}

variable "iam_group_name_ro_access" {
  description = "the name of the IAM group that will have read-only access"
  default     = "terraform_ro_access"
}

# ---------------------------------------------------------------------------
# codepipeline
# ---------------------------------------------------------------------------


variable "repo_connection_name" {
  type = string
}

variable "codebuild_role_name" {
  type    = string
  default = "infra-codebuild-role"
}

variable "codepipeline_role_name" {
  type    = string
  default = "infra-codepipeline-role"
}

variable "codebuild_policy_name" {
  type    = string
  default = "infra-codebuild-policy"
}

variable "codepipeline_policy_name" {
  type    = string
  default = "infra-codepipeline-policy"
}

variable "codebuild_plan_project_name" {
  type    = string
  default = "infra-codebuild-project-plan"
}

variable "codebuild_apply_project_name" {
  type    = string
  default = "infra-codebuild-project-apply"
}

variable "codepipeline_name" {
  type    = string
  default = "infra-codepipeline"
}