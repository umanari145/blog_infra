# blog_infra

[blog](https://github.com/umanari145/blog)のinfraを切り出し

### infra
- api_paths.xlsx・・APIGatewayのパス情報をここから展開
- apigateway.tf・・APIGatewayのtfファイル
- ecr_build.sh・・ECRの構築とイメージのpush。`bash ecr_builds.sh`でECR作成とコンテナイメージのpush
- generator.py・・apigateway.tfを作成するためのツール　コンテナ内で以下コマンドで`cd /app/infra && python generator.py`でtfファイル作成
- lambda.tf・・lambdaのtfファイル
- provider.tf・・providerの設定ファイル
- template.tf.j2・・generatorのtemplate。ここをgeneratorはここを経由してtfファイルを作成する
- terraform.tfstate・・terraformの状態 
- terraform.tfstate.backup・・terraformの状態(backup)
- terraform.tfvars.dummy・・terraformの変数(dummyがない方の拡張子が実際の値)
- variables.tf・・terraform内で使う変数の定義
- aws_configure.txt.default・・awsの設定情報。ecr_build.shで使用(.defautがない方の拡張子が実施の値)

#### 実際の構築コマンド

1. `bash ecr_build`
2. `terraform apply -var-file terraform.tfvars` で構築
3. 構築後は`.github/workflows/deploy.yml`で更新が走る

### infra(terraform)

```
#最初だけ
terraform init

# 確認
terraform plan -var-file terraform.tfvars

# 構築
terraform apply -var-file terraform.tfvars

# 削除
terraform destroy -var-file terraform.tfvars
```

### lambda & ecr terraform
 
https://zenn.dev/ikedam/articles/4d0646c8effb1c

https://qiita.com/suzuki-navi/items/47d7093278ee9f4d1147

https://thaim.hatenablog.jp/entry/2021/07/05/081325

https://qiita.com/neruneruo/items/d395fef4929c9486ec0a#ecr

https://qiita.com/hayaosato/items/d6049cf68c84a26845d2

https://qiita.com/wwalpha/items/4a3e4f1f54e896633c01



terraform import<br>
すでに既存にリソースがある場合<br>
terraform import (terraforのりソースの種類).(terraformのリソース名) リソースのID、名前などの何らかのユニーク情報
```
terraform import aws_cloudwatch_log_group.log_group :/aws/lambda/blogLambdaFunction:
```
https://zenn.dev/yumainaura/articles/qiita-2023-09-15t13_31_48-09_00

### cloudflount
https://hisuiblog.com/react-terraform-cloudfront-s3-deploy/<br>
https://github.com/hisuihisui/terraform_aws_deploy_practice