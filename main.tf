module "backend" {
  source = "./modules/backend"

  aws_account = data.aws_caller_identity.current.account_id
  aws_region  = var.aws_region

  aws_environment               = var.aws_environment
  s3_bucket_name                = var.s3_bucket_name
  dynamodb_table_name           = var.dynamodb_table_name
  dynamodb_read_capacity_units  = var.dynamodb_read_capacity_units
  dynamodb_write_capacity_units = var.dynamodb_write_capacity_units
  iam_group_name_rw_access      = var.iam_group_name_rw_access
  iam_group_name_ro_access      = var.iam_group_name_ro_access
}

module "codepipeline" {
  source = "./modules/codepipeline"

  aws_account = data.aws_caller_identity.current.account_id
  aws_region  = var.aws_region

  repo_connection_arn = data.aws_codestarconnections_connection.connection.arn

  s3_bucket_name_codepipeline  = var.s3_bucket_name_codepipeline
  codebuild_role_name          = var.codebuild_role_name
  codepipeline_role_name       = var.codepipeline_role_name
  codebuild_policy_name        = var.codebuild_policy_name
  codepipeline_policy_name     = var.codepipeline_policy_name
  codebuild_plan_project_name  = var.codebuild_plan_project_name
  codebuild_apply_project_name = var.codebuild_apply_project_name
  codepipeline_name            = var.codepipeline_name
}

module "network" {
  source = "./modules/network"

  aws_region = var.aws_region

  vpc_tag_name               = var.vpc_tag_name
  route_table_tag_name       = var.route_table_tag_name
  vpc_cidr_block             = var.vpc_cidr_block
  private_subnet_cidr_blocks = var.private_subnet_cidr_blocks
  public_subnet_cidr_blocks  = var.public_subnet_cidr_blocks
  private_subnet_tag_name    = var.private_subnet_tag_name
  public_subnet_tag_name     = var.public_subnet_tag_name
  availability_zones         = var.availability_zones
  eks_cluster_name           = var.eks_cluster_name
}