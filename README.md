# github-actions-docker-push-terraform

AWS に GitHub Actions で Docker イメージをプッシュするためのリソースを作成する Terraform テンプレート

## Usage

- Terraform 実行に必要な環境変数を設定する

```bash
touch variables.tfvars

cat <<EOF > variables.tfvars
github_organization = "variable_value"
github_repository = "another_value"
EOF
```

- Terraform 実行

```bash
terraform init
terraform plan -var-file="variables.tfvars"
terraform apply -var-file="variables.tfvars"
```