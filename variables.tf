variable "aws_region" {
  description = "the AWS region"
}

variable "aws_environment" {
  description = "the AWS environment"
}

# ---------------------------------------------------------------------------
# backend
# ---------------------------------------------------------------------------

variable "s3_bucket_name" {
  default     = "terraform-state"
  description = "the name of the S3 bucket which will be used to store state files"
}

variable "dynamodb_table_name" {
  default     = "terraform-lock"
  description = "the name of the DynamoDB table which will be used for state locking"
}

variable "dynamodb_read_capacity_units" {
  default     = 5
  description = "the amount of read capacity units for the DynamoDB table"
}

variable "dynamodb_write_capacity_units" {
  default     = 1
  description = "the amount of write capacity units for the DynamoDB table"
}

variable "iam_group_name_rw_access" {
  default     = "terraform-state-iam_group_name_rw_access"
  description = "the name of the IAM group that will have read-write access"
  #default     = "terraform_rw_access"
}

variable "iam_group_name_ro_access" {
  default     = "terraform-state-iam_group_name_ro_access"
  description = "the name of the IAM group that will have read-only access"
  #default     = "terraform_ro_access"
}

# ---------------------------------------------------------------------------
# codepipeline
# ---------------------------------------------------------------------------

variable "repo_connection_name" {
  type    = string
  default = "personal-repo"
}

variable "s3_bucket_name_codepipeline" {
  type    = string
  default = "infra-codepipeline"
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

variable "codebuild_deploy_project_name" {
  type    = string
  default = "infra-codebuild-project-deploy"
}

variable "codepipeline_name" {
  type    = string
  default = "infra-codepipeline"
}

# ---------------------------------------------------------------------------
# network
# ---------------------------------------------------------------------------

variable "vpc_tag_name" {
  type        = string
  default     = "main"
  description = "Name tag for the VPC"
}

variable "route_table_tag_name" {
  type        = string
  default     = "main"
  description = "Route table description"
}

variable "vpc_cidr_block" {
  type        = string
  default     = "10.0.0.0/16"
  description = "CIDR block range for vpc"
}

variable "private_subnet_cidr_blocks" {
  type        = list(string)
  default     = ["10.0.0.0/24", "10.0.1.0/24"]
  description = "CIDR block range for the private subnet"
}

variable "public_subnet_cidr_blocks" {
  type        = list(string)
  default     = ["10.0.2.0/24", "10.0.3.0/24"]
  description = "CIDR block range for the public subnet"
}

variable "private_subnet_tag_name" {
  type        = string
  default     = "Custom Kubernetes cluster private subnet"
  description = "Name tag for the private subnet"
}

variable "public_subnet_tag_name" {
  type        = string
  default     = "Custom Kubernetes cluster public subnet"
  description = "Name tag for the public subnet"
}

variable "availability_zones" {
  type        = list(string)
  default     = ["us-east-1a", "us-east-1b"]
  description = "List of availability zones for the selected region"
}

# ---------------------------------------------------------------------------
# eks
# ---------------------------------------------------------------------------

variable "eks_cluster_name" {
  type        = string
  default     = "py-grpc-cluster"
  description = "The name of the EKS cluster"
}

variable "node_group_name" {
  type        = string
  default     = "py-grpc-node-group"
  description = "Name of the Node Group"
}

variable "endpoint_private_access" {
  type        = bool
  default     = true
  description = "Indicates whether or not the Amazon EKS private API server endpoint is enabled."
}

variable "endpoint_public_access" {
  type        = bool
  default     = true
  description = "Indicates whether or not the Amazon EKS public API server endpoint is enabled."
}

variable "ami_type" {
  type        = string
  default     = "AL2_x86_64"
  description = "Type of Amazon Machine Image (AMI) associated with the EKS Node Group. Defaults to AL2_x86_64. Valid values: AL2_x86_64, AL2_x86_64_GPU."
}

variable "disk_size" {
  type        = number
  default     = 20
  description = "Disk size in GiB for worker nodes. Defaults to 20."

}

variable "instance_types" {
  type        = list(string)
  default     = ["t3.medium"]
  description = "Set of instance types associated with the EKS Node Group."
}

variable "pvt_desired_size" {
  type        = number
  default     = 1
  description = "Desired number of worker nodes in private subnet"
}

variable "pvt_max_size" {
  type        = number
  default     = 1
  description = "Maximum number of worker nodes in private subnet."
}

variable "pvt_min_size" {
  type        = number
  default     = 1
  description = "Minimum number of worker nodes in private subnet."
}

variable "pblc_desired_size" {
  type        = number
  default     = 1
  description = "Desired number of worker nodes in public subnet"
}

variable "pblc_max_size" {
  type        = number
  default     = 1
  description = "Maximum number of worker nodes in public subnet."

}

variable "pblc_min_size" {
  type        = number
  default     = 1
  description = "Minimum number of worker nodes in public subnet."
}

variable "cluster_sg_name" {
  type        = string
  default     = "cluster-sg"
  description = "Name of the EKS cluster Security Group"
}

variable "nodes_sg_name" {
  type        = string
  default     = "nodes-sg"
  description = "Name of the EKS node group Security Group"
}

variable "deployment_file" {
  type        = string
  default     = "./deployments/deployment.yaml"
  description = "The deployment file"
}