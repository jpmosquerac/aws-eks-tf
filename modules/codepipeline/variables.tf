variable "aws_account" {
  description = "the AWS account id"
}

variable "aws_region" {
  description = "the AWS region"
}

variable "repo_connection_arn" {
  type = string
}

variable "s3_bucket_name_codepipeline" {
  type = string
}

variable "codebuild_role_name" {
  type = string
}

variable "codepipeline_role_name" {
  type = string
}

variable "codebuild_policy_name" {
  type = string
}

variable "codepipeline_policy_name" {
  type = string
}

variable "codebuild_plan_project_name" {
  type = string
}

variable "codebuild_apply_project_name" {
  type = string
}

variable "codepipeline_name" {
  type = string
}