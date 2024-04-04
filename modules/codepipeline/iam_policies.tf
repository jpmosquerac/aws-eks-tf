data "aws_iam_policy_document" "codepipeline_policy_document" {
  statement {
    actions   = ["cloudwatch:*"]
    resources = ["*"]
    effect    = "Allow"
  }
  statement {
    actions = ["codebuild:*"]
    resources = [
      "arn:aws:codebuild:${var.aws_region}:${var.aws_account}:project/${var.codebuild_plan_project_name}",
      "arn:aws:codebuild:${var.aws_region}:${var.aws_account}:project/${var.codebuild_apply_project_name}"
    ]
    effect = "Allow"
  }

  statement {
    actions   = ["s3:*"]
    resources = ["${aws_s3_bucket.s3_bucket_codepipeline.arn}/*"]
    effect    = "Allow"
  }

  statement {
    actions   = ["codestar-connections:UseConnection"]
    resources = ["*"]
    effect    = "Allow"
  }

  statement {
    actions = [
      "appconfig:StartDeployment",
      "appconfig:GetDeployment",
      "appconfig:StopDeployment"
    ]
    resources = ["*"]
    effect    = "Allow"
  }

  statement {
    actions   = ["codecommit:GetRepository"]
    resources = ["*"]
    effect    = "Allow"
  }
}

data "aws_iam_policy_document" "codebuild_policy_document" {
  statement {
    actions   = ["*"]
    resources = ["*"]
    effect    = "Allow"
  }
}