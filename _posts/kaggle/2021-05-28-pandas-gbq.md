---
layout: post
title: "pandas-gbq"
date: 2021-05-28
excerpt: "pandas-gbqの使い方について"
kaggle: true
hide_from_post: true
tag: ["pandas", "pandas-gbq"]
comments: false
sort_key: "2022-01-17"
update_dates: ["2022-01-17","2021-12-08","2021-10-21","2021-10-20","2021-08-14","2021-05-28"]
---

# pandas-gbqの使い方について
 - 簡単にpandasとbigqueryを結合できる
 - 最初に認証を通す必要がある
   - 使えるクレデンシャルがない場合、`~/.config/pandas_gbq/bigquery_credentials.dat`にユーザ認証で通した一時的なクレデンシャルが作成される
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

## 認証

### クレデンシャル(サービスアカウントの認証情報)を用いて初期化する
 - AWSでbigqueryにアクセスするときなどに必要な措置
 - `google.oauth2`には以下のライブラリが必要
   - `google-api-python-client google-auth-httplib2 google-auth-oauthlib`

```python
import pandas_gbq
from google.oauth2 import service_account

pandas_gbq.context.credentials = (
  service_account.Credentials.from_service_account_file("path_of_creds.json")
)
```

### 対話式のUIでクレデンシャルを初期化する
 - ユースケース
   - キャッシュに保存されたクレデンシャルを再設定したい時
   - 明示的に、driveのスコープを有効化する時

```python
import pydata_google_auth
SCOPES = [
    'https://www.googleapis.com/auth/cloud-platform',
    'https://www.googleapis.com/auth/drive',
]
credentials = pydata_google_auth.get_user_credentials(
    SCOPES,
    auth_local_webserver=False,
    # credentials_cache=pydata_google_auth.cache.NOOP, # 有効化すると、明示的にキャッシュを使用しない
)
pd.read_gbq(query, projectid, dialect='standard', use_bqstorage_api=True, credentials=credentials)
```

### キャッシュされたユーザ認証のクレデンシャルを明示的に使う

```python
from pathlib import Path
import pandas as pd
import pydata_google_auth

credentials = pydata_google_auth.load_user_credentials(
    Path("~/.config/pandas_gbq/bigquery_credentials.dat").expanduser()
)


df = pd.read_gbq(query, projectid, dialect="standard", credentials=credentials, use_bqstorage_api=True)
```
 - 自動で優先される`GOOGLE_APPLICATION_CREDENTIALS`が設定されてしまっているときなどに有効

### dockerのコンテナと認証情報を共有する
 - dockerでpandas_gbqを使用している際に、クレデンシャルをローカルと共有し、テストを通すために必要

```console
$ docker run -v ~/.config/pandas_gbq/:/root/.config/pandas_gbq -it <container-name>
```

## `use_bqstorage_api`オプションについて
 - このオプションを有効化するとダウンロードが高速化する
 - `bqstorage`の機能を使うには `bigquery.readsessions.create`, `bigquery.readsessions.getData`, `bigquery.readsessions.update`の権限がIAMに設定されている必要がある

---

## トラブルシューティング

### クレデンシャルを適切に設定しているのpermission errorが発生する
 - `GOOGLE_APPLICATION_CREDENTIALS`の環境変数が設定されているとキャッシュよりそちらを優先してしまう
 - jupyter等を起動する前に`$ unset GOOGLE_APPLICATION_CREDENTIALS`して環境変数を削除している必要がある
   - jupyter内で`!echo $GOOGLE_APPLICATION_CREDENTIALS`することで設定状況を確認することができる
