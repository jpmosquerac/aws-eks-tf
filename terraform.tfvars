aws_region = "us-east-1"

aws_environment = "dev"

# ---------------------------------------------------------------------------
# backend
# ---------------------------------------------------------------------------

s3_bucket_name = "terraform-state"

dynamodb_table_name = "terraform-lock"

iam_group_name_rw_access = "terraform-state-iam_group_name_rw_access"

iam_group_name_ro_access = "terraform-state-iam_group_name_ro_access"

# ---------------------------------------------------------------------------
# codepipeline
# ---------------------------------------------------------------------------

repo_connection_name = "personal-repo"