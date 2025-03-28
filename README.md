# blog_infra

[blog](https://github.com/umanari145/blog)のinfraを切り出し

### infra
- api_paths.xlsx・・APIGatewayのパス情報をここから展開
- apigateway2.tf・・APIGatewayのtfファイル
- ecr_build.sh・・ECRの構築とイメージのpush。`bash ecr_builds.sh`でECR作成とコンテナイメージのpush
- generator2.py・・apigateway.tfを作成するためのツール　コンテナ内で以下コマンドで`cd /app/infra && python generator.py`でtfファイル作成
- lambda.tf・・lambdaのtfファイル
- provider.tf・・providerの設定ファイル
- template2.tf.j2・・generatorのtemplate。ここをgeneratorはここを経由してtfファイルを作成する
- terraform.tfstate・・terraformの状態 
- terraform.tfstate.backup・・terraformの状態(backup)
- terraform.tfvars.dummy・・terraformの変数(dummyがない方の拡張子が実際の値)
- variables.tf・・terraform内で使う変数の定義
- aws_configure.txt.default・・awsの設定情報。ecr_build.shで使用(.defautがない方の拡張子が実施の値)

### 環境変数読み込み
```
source aws_configure.txt
```

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

### jinja構文
https://qiita.com/simonritchie/items/cc2021ac6860e92de25d

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
高速な静的・動的コンテンツの配信（例: HTML、CSS、JavaScript、画像、動画など）
https://github.com/hisuihisui/terraform_aws_deploy_practice

### acm
AWSが提供するSSL/TLS証明書の発行・管理サービス<br>
https://dev.classmethod.jp/articles/terraform-aws-certificate-validation/<br>
https://qiita.com/Ogin0pan/items/199986966e541d9e9ba4<br>
https://qiita.com/kanadeee/items/752e20af5b071ef0e011<br>
https://qiita.com/aokabin/items/b03850c450d50abed952<br>
https://qiita.com/kanadeee/items/e6d06d36b2d0b97c33a8<br>
https://qiita.com/kekkepy/items/8f5aeb26985a9cea39dd<br>
https://qiita.com/tos-miyake/items/f0e5f28f2a69e4d39422

### ネームサーバー設定変更
```
nslookup -type=NS skill-up-engineering.com

Non-authoritative answer:
skill-up-engineering.com        nameserver = xxxxxx.com.
skill-up-engineering.com        nameserver = xxxxxx.com.
# 上記のnameserverがNSレコードのネームサーバーになっていることを確認
```

## api_gateway

https://blog.linkode.co.jp/entry/2023/09/15/120000<br>
https://zenn.dev/fdnsy/articles/86897abce0bbf5<br>
https://qiita.com/sabmeua/items/c686dbc24ab23fb68187

デプロイコマンドは下記で

1.デプロイメント作成
```
aws apigateway create-deployment \
  --rest-api-id [api_id] \
  --stage-name [stage dev/stg/prodなど] \
  --description "[message]"
```

2.ステージの作成
```
aws apigateway create-stage \
  --rest-api-id $API_ID \
  --stage-name [stage] 
  --deployment-id [deployment_id]
```

### ファイル単位のシェル
`bash terraform_agent.sh ******.tf`

```
Choose action:
1) Apply
2) Destroy
```
1,2以外はexit

echo文を貼り付けてそのまま実行