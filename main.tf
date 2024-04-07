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

module "eks" {
  source = "./modules/eks"

  eks_cluster_subnet_ids = concat([for element in module.network.private_subnet : element.id], [for element in module.network.public_subnet : element.id])
  private_subnet_ids     = [for element in module.network.private_subnet : element.id]
  public_subnet_ids      = [for element in module.network.public_subnet : element.id]
  vpc_id                 = module.network.aws_vpc

  eks_cluster_name        = var.eks_cluster_name
  node_group_name         = var.node_group_name
  endpoint_private_access = var.endpoint_private_access
  endpoint_public_access  = var.endpoint_public_access
  ami_type                = var.ami_type
  disk_size               = var.disk_size
  instance_types          = var.instance_types
  pvt_desired_size        = var.pvt_desired_size
  pvt_max_size            = var.pvt_max_size
  pvt_min_size            = var.pvt_min_size
  pblc_desired_size       = var.pblc_desired_size
  pblc_max_size           = var.pblc_max_size
  pblc_min_size           = var.pblc_min_size
  cluster_sg_name         = var.cluster_sg_name
  nodes_sg_name           = var.nodes_sg_name
}

# module "deployments" {
#   source = "./modules/deployments"

#   aws_eks_cluster            = module.eks.aws_eks_cluster
#   aws_eks_node_group_private = var.node_group_name
#   aws_eks_node_group_public  = "${var.node_group_name}-public"
# }