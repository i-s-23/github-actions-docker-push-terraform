variable "github_organization" {
  type        = string
  description = "GithubのOrganization名. or Organizationに所属していない場合Githubのユーザ名"
  default     = "i-s-23"
}

variable "github_repository" {
  type        = string
  description = "Githubのリポジトリ名"
  default     = "github-actions-docker-push-terraform"
}
