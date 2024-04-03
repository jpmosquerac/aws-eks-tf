variable "aws_account" {
  description = "the AWS account id"
}

variable "aws_region" {
  description = "the AWS region"
}

variable "infra_folder" {
  description = "the folder where tf starts"
}

variable "repo_connection_arn" {
    type = string
    default = "personal-repo"
}

variable "s3_bucket_name_codepipeline" {
    type = string
    default = "infra-codepipeline"
}

variable "codebuild_role_name" {
    type = string
    default = "infra-codebuild-role" 
}

variable "codepipeline_role_name" {
    type = string
    default = "infra-codepipeline-role"
}

variable "codebuild_policy_name" {
    type = string
    default = "infra-codebuild-policy" 
}

variable "codepipeline_policy_name" {
    type = string
    default = "infra-codepipeline-policy"
}

variable "codebuild_plan_project_name" {
    type = string
    default = "infra-codebuild-project-plan" 
}

variable "codebuild_apply_project_name" {
    type = string
    default = "infra-codebuild-project-apply" 
}

variable "codepipeline_name" {
    type = string
    default = "infra-codepipeline" 
}