---
layout: post
title: "jupyter bigquery"
date: 2023-08-11
excerpt: "jupyter notebookでbigqueryを利用する方法"
tag: ["jupyter", "kaggle", "python", "bigquery"]
comments: false
sort_key: "2023-08-11"
update_dates: ["2023-08-11"]
---

# jupyter notebookでbigqueryを利用する方法

## 概要
 - 手法としては`google-cloud-bigquery`と`pandas_gbq`を利用する方法の２つが存在する
   - `pandas_gbq`は機能的に推奨できない点があり、`google-cloud-bigquery`を使用したほうがいい旨のアドバイスを貰ったことがある
 - `$ gcloud auth login`すれば透過的に認証が利用できるはずであるが、利用できないことがある

## `google-cloud-bigquery`を利用する場合

```python
# pip install pydata-google-auth google-auth google-auth-oauthlib google-auth-httplib2 google-api-python-client google-cloud-bigquery \
#   google-cloud-bigquery-storage db-dtypes

import pydata_google_auth
from google.cloud import bigquery

SCOPES = [
    'https://www.googleapis.com/auth/cloud-platform',
    'https://www.googleapis.com/auth/drive',
]
credentials = pydata_google_auth.get_user_credentials(
    SCOPES,
    auth_local_webserver=False,
    # credentials_cache=pydata_google_auth.cache.NOOP, # 有効化すると、明示的にキャッシュを使用しない
)

client = bigquery.Client(project="<your-project-id>", credentials=credentials)

query = """
SELECT name, COUNT(*) as count
FROM `bigquery-public-data.usa_names.usa_1910_current`
WHERE state = 'CA'
GROUP BY name
ORDER BY count DESC
LIMIT 10
"""

# データフレームに変換
df = client.query(query).to_dataframe()
df
```

| name      |   count |
|:----------|--------:|
| Jean      |     221 |
| Francis   |     219 |
| Guadalupe |     216 |
| Jessie    |     215 |
| Marion    |     213 |
| Lee       |     206 |
| Leslie    |     206 |
| Frankie   |     199 |
| Jackie    |     197 |
| Noel      |     197 |
