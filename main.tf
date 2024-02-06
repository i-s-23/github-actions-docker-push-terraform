data "aws_caller_identity" "current" {}
data "aws_region" "current" {}

locals {
  account_id = data.aws_caller_identity.current.account_id
  region     = data.aws_region.current.id
}

resource "aws_ecr_repository" "ECRRepository" {
  name = "python-test"
}

resource "aws_iam_policy" "ecr_push_policy" {
  name = "ci-cd-ecr-push"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        "Effect" : "Allow",
        "Action" : [
          "ecr:GetDownloadUrlForLayer",
          "ecr:BatchGetImage",
          "ecr:BatchCheckLayerAvailability",
          "ecr:PutImage",
          "ecr:InitiateLayerUpload",
          "ecr:UploadLayerPart",
          "ecr:CompleteLayerUpload"
        ],
        "Resource" : ["arn:aws:ecr:${local.region}:${local.account_id}:repository/${aws_ecr_repository.ECRRepository.name}"]
      }
    ]
  })
}

module "oidc_github" {
  source  = "unfunco/oidc-github/aws"
  version = "1.7.1"

  github_repositories = [
    "${var.github_organization}/${var.github_repository}"
  ]
  iam_role_policy_arns = [
    aws_iam_policy.ecr_push_policy.arn
  ]
}

provider "aws" {
  region = "us-east-1"
}
