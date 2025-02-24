---
layout: post
title: "gcp cloud storage"
date: 2022-05-12
excerpt: "gcp cloud storageの使い方"
config: true
tag: ["gcp", "cloud storage", "object storage"]
comments: false
sort_key: "2022-05-13"
update_dates: ["2022-05-13"]
---

# gcp cloud storageの使い方

## 概要
 - GCPのオブジェクトストレージ
 - 様々なプログラミング言語のラッパーが用意されている
 - S3のように静的なコンテンツをhttpでホストすることができる
   - httpsを使用したい場合はload-balancingを併用することで達成できる

## `google-cloud-storage` によるファイルの読み込み

```python
import json
from google.cloud import storage
from google.oauth2.service_account import Credentials

service_account_secret_json = '''{
  "type": "service_account",
  "project_id": "...",
  "private_key_id": "...",
  "private_key": "...",
  "client_email": "...",
  "client_id": "108287448231007079701",
  "auth_uri": "https://accounts.google.com/o/oauth2/auth",
  "token_uri": "https://oauth2.googleapis.com/token",
  "auth_provider_x509_cert_url": "https://www.googleapis.com/oauth2/v1/certs",
  "client_x509_cert_url": "...",
  "universe_domain": "googleapis.com"
}'''.strip()

service_account_info = json.loads(service_account_secret_json, strict=False)
service_account_info

credentials = Credentials.from_service_account_info(service_account_info)

client = storage.Client(credentials=credentials, project=service_account_info["project_id"])

def download_directory(bucket_name, prefix, local_destination):
    """
    GCS の指定バケット内、prefix 以下のファイルをローカルの local_destination に再帰的にダウンロードする

    :param bucket_name: GCS バケット名
    :param prefix: バケット内のディレクトリパス（末尾に '/' を含む）
    :param local_destination: ローカルの保存先ディレクトリパス
    """
    client = storage.Client(credentials=credentials, project=service_account_info["project_id"])
    bucket = client.get_bucket(bucket_name)

    # prefix 以下の全てのブロブをリストアップ
    blobs = bucket.list_blobs(prefix=prefix)

    for blob in blobs:
        # プレフィックス部分を除いた相対パスを生成
        relative_path = blob.name[len(prefix):]
        # 空文字列の場合はディレクトリ（またはプレフィックスのみ）なのでスキップ
        if not relative_path:
            continue
        # ローカルの出力先パスを生成
        local_path = os.path.join(local_destination, relative_path)
        os.makedirs(os.path.dirname(local_path), exist_ok=True)
        print(f"Downloading {blob.name} to {local_path} ...")
        blob.download_to_filename(local_path)

# 使用例
bucket_name = "bucket-name"
prefix = "target-directory/"  # ダウンロードしたいGCS上のディレクトリ
local_destination = "./local-save-directory"  # ローカルに保存するディレクトリ

download_directory(bucket_name, prefix, local_destination)
```

## `gcsfs` によるファイルの読み書き

### 具体例

```python
import gcsfs

# `gcloud auth login`で対象のprojectの認証が通っている必要性
fs = gcsfs.GCSFileSystem()

# ファイルを書き込み
with fs.open("gs://<bucket-name>/my-file.txt", "w") as fp:
    fp.write("test string.")

# ファイルの読み込み
with fs.open("gs://<bucket-name>/my-file.txt", "r") as fp:
    print(fp.read())

# bucket名を指定
# my-file.txtが表示される
print(fs.ls("gs://<bucket-name>"))
```


## 参考
 - [静的ウェブサイトをホストする/docs](https://cloud.google.com/storage/docs/hosting-static-website)
