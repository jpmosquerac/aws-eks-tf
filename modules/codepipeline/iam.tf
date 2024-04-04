resource "aws_iam_policy" "codepipeline_policy" {
  name   = var.codepipeline_policy_name
  path   = "/"
  policy = data.aws_iam_policy_document.codepipeline_policy_document.json
}

resource "aws_iam_role" "codepipeline-role" {
  name = var.codepipeline_role_name

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "codepipeline.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}

resource "aws_iam_role_policy_attachment" "codepipeline_policy_attachment" {
  policy_arn = aws_iam_policy.codepipeline_policy.arn
  role       = aws_iam_role.codepipeline-role.id
}

resource "aws_iam_policy" "codebuild_policy" {
  name   = var.codebuild_policy_name
  path   = "/"
  policy = data.aws_iam_policy_document.codebuild_policy_document.json
}

resource "aws_iam_role" "codebuild_role" {
  name = var.codebuild_role_name

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "codebuild.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}

resource "aws_iam_role_policy_attachment" "codebuild_policy_attachment1" {
  policy_arn = aws_iam_policy.codebuild_policy.arn
  role       = aws_iam_role.codebuild_role.id
}