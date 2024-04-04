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
  infra_folder        = var.infra_folder
}