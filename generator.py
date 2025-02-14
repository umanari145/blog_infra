import pandas as pd
from jinja2 import Environment, FileSystemLoader

# 入力Excelファイルとテンプレート、出力ファイルの設定
excel_file_path = "api_paths.xlsx"  # Excelファイル名
template_file_path = "template.tf.j2"  # Terraformテンプレートファイル
output_file_path = "apigateway.tf"  # 出力ファイル名
api_name = "blog_api"
description="skill-up-engineering.comのblog"

# Excelファイルの読み込み
excel_file = "api_paths.xlsx"  # Excelファイル名
df_resources = pd.read_excel(excel_file, sheet_name="resource")
df_methods = pd.read_excel(excel_file, sheet_name="method")

# リソース情報の辞書化
resources = {row["id"]: row["path"] for _, row in df_resources.iterrows()}

# メソッド情報のリスト化
methods = [
    {
        "path": resources[row["resource_id"]],
        "method": row["method"],
        "lambda": row["lambda"]
    }
    for _, row in df_methods.iterrows()
]

# Jinja環境設定（テンプレートのディレクトリを指定）
env = Environment(loader=FileSystemLoader("."))

# Jinjaテンプレートをコンパイル
template = env.from_string(terraform_template)

# Terraformコードをレンダリング
terraform_code = template.render(methods=methods)

# terraform.tf に出力
with open("terraform.tf", "w") as f:
    f.write(terraform_code)

print("Terraformコードが 'terraform.tf' に生成されました。")
