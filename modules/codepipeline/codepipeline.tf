resource "aws_codepipeline" "codepipeline" {

  name          = var.codepipeline_name
  pipeline_type = "V2"
  role_arn      = aws_iam_role.codepipeline-role.arn

  artifact_store {
    type     = "S3"
    location = aws_s3_bucket.s3_bucket_codepipeline.bucket
  }

  stage {
    name = "Source"
    action {
      name             = "Source"
      category         = "Source"
      owner            = "AWS"
      provider         = "CodeStarSourceConnection"
      version          = "1"
      output_artifacts = ["source_output"]
      configuration = {
        ConnectionArn    = var.repo_connection_arn
        FullRepositoryId = "jpmosquerac/py-grpc-aws-eks-tf"
        BranchName       = "main"
      }
    }
  }

  stage {
    name = "Plan"
    action {
      name            = "Build"
      category        = "Build"
      provider        = "CodeBuild"
      version         = "1"
      owner           = "AWS"
      input_artifacts = ["source_output"]
      configuration = {
        ProjectName = aws_codebuild_project.codebuild_project_plan_stage.name
      }
    }
  }

  stage {
    name = "Deploy"
    action {
      name            = "Deploy"
      category        = "Build"
      provider        = "CodeBuild"
      version         = "1"
      owner           = "AWS"
      input_artifacts = ["source_output"]
      configuration = {
        ProjectName = aws_codebuild_project.codebuild_project_apply_stage.name
      }
    }
  }

}