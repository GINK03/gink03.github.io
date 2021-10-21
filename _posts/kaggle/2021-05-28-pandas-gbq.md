---
layout: post
title: "pandas-gbq"
date: 2021-05-28
excerpt: "pandas-gbqの使い方について"
kaggle: true
hide_from_post: true
tag: ["pandas", "pandas-gbq"]
comments: false
---

# pandas-gbqの使い方について
 - 簡単にpandasとbigqueryを結合できる
 - 最初に認証を通す必要がある
 - データのアップロード時には予め`bq mk ~`でバケットを作成する必要がある
 - あまり大きなデータをダウンロードできない
 - `use_bqstorage_api=True`でダウンロードを高速化できる

## インストール

```console
$ python3 -m pip install pandas-gbq
```

## データのクエリとダウンロード

```python
query = f"""
    SELECT
	  *
    FROM
      `bigquery-public-data.covid19_nyt.excess_deaths`
	LIMIT 1000
"""
projectid = 'starry-lattice-256603'
df = pd.read_gbq(query, projectid, dialect='standard', use_bqstorage_api=True)
```

## データのアップロード

```python
project_id = "starry-lattice-256603"
table_ida = "any_bucket.target_table01"
df.to_gbq(table_id, project_id=project_id, if_exists="replace")
```

## クレデンシャル(サービスアカウントの認証情報)を用いて初期化する
 - AWSでbigqueryにアクセスするときなどに必要な措置

```python
import pandas_gbq
from google.oauth2 import service_account

pandas_gbq.context.credentials = (
  service_account.Credentials.from_service_account_file("path_of_creds.json")
)
```

## 対話式のUIでクレデンシャルを初期化する
 - キャッシュに保存されたクレデンシャルを再設定したい時など

```python
import pydata_google_auth
SCOPES = [
    'https://www.googleapis.com/auth/cloud-platform',
    'https://www.googleapis.com/auth/drive',
]
credentials = pydata_google_auth.get_user_credentials(
    SCOPES,
    auth_local_webserver=False,
)
pd.read_gbq(query, projectid, dialect='standard', use_bqstorage_api=True, credentials=credentials)
```
