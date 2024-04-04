data "aws_caller_identity" "current" {}

data "aws_codestarconnections_connection" "connection" {
  name = var.repo_connection_name
}