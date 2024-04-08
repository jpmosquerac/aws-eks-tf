resource "aws_codebuild_project" "codebuild_project_plan_stage" {
  name         = var.codebuild_plan_project_name
  description  = "Terraform Planning Stage for infra"
  service_role = aws_iam_role.codebuild_role.arn

  artifacts {
    type = "CODEPIPELINE"
  }

  environment {
    compute_type = "BUILD_GENERAL1_SMALL"
    image        = "hashicorp/terraform:latest"
    type         = "LINUX_CONTAINER"
  }

  source {
    type      = "CODEPIPELINE"
    buildspec = file("./modules/codepipeline/buildspecs/plan_buildspec.yml")
  }
}

resource "aws_codebuild_project" "codebuild_project_apply_stage" {
  name         = var.codebuild_apply_project_name
  description  = "Terraform Apply Stage for infra"
  service_role = aws_iam_role.codebuild_role.arn

  artifacts {
    type = "CODEPIPELINE"
  }

  environment {
    compute_type = "BUILD_GENERAL1_SMALL"
    image        = "hashicorp/terraform:latest"
    type         = "LINUX_CONTAINER"
  }

  source {
    type      = "CODEPIPELINE"
    buildspec = file("./modules/codepipeline/buildspecs/apply_buildspec.yml")
  }
}

resource "aws_codebuild_project" "codebuild_project_deploy_stage" {
  name         = var.codebuild_deploy_project_name
  description  = "Deploy app stage"
  service_role = aws_iam_role.codebuild_role.arn

  artifacts {
    type = "CODEPIPELINE"
  }

  environment {
    compute_type = "BUILD_GENERAL1_SMALL"
    image        = "amazonlinux:latest"
    type         = "LINUX_CONTAINER"

    environment_variable {
      name  = "AWS_REGION"
      value = var.aws_region
    }

    environment_variable {
      name  = "CLUSTER_NAME"
      value = var.eks_cluster_name
    }

    environment_variable {
      name  = "DEPLOYMENT_FILE"
      value = "./deployments/server_deployment.yaml"
    }

    environment_variable {
      name  = "SERVICE_FILE"
      value = "./deployments/service.yaml"
    }

    environment_variable {
      name  = "INGRESS_FILE"
      value = "./deployments/ingress.yaml"
    }
  }

  source {
    type      = "CODEPIPELINE"
    buildspec = file("./modules/codepipeline/buildspecs/deploy_buildspec.yml")
  }
}