---
layout: post
title: "gcp secret manager"
date: 2023-03-30
excerpt: "gcp secret managerの使い方"
tags: ["secret manager", "gcp", "api"]
config: true
comments: false
sort_key: "2023-03-30"
update_dates: ["2023-03-30"]
---

# gcp secret managerの使い方

## 概要
 - gcp上にシークレットを補完するもの
 - クレデンシャルを共有せずに済むので便利
 - シークレットという粒度の中に、バージョンが有り、バージョンに秘密の文章が記されている
 - 使用するには事前に`secret manager`のAPIが有効化されている必要がある

## インストール

```console
$ python3 -m pip install google-cloud-secret-manager
```

## 具体例

### シークレットを作成する

```console
$ gcloud secrets create <secret-id> --replication-policy="automatic"
```

### シークレットにバージョンを追加する

**ファイルから**
```console
$ gcloud secrets versions add <secret-id> --data-file="/path/to/file.txt"
```

**標準入力から**
```console
$ echo -n "this is my super secret data" | gcloud secrets versions add secret-id --data-file=-
```

### シークレットのバージョンにアクセスする

**cui**
```console
$ gcloud secrets versions access <version-id> --secret=<secret-id>
```

**python**
```python
from google.cloud import secretmanager

project_id = "starry-lattice-256603"
secret_id  = "test-secret-id"
version_id = "latest"

client = secretmanager.SecretManagerServiceClient()
name = f"projects/{project_id}/secrets/{secret_id}/versions/{version_id}"
response = client.access_secret_version(request={"name": name})
payload = response.payload.data.decode("UTF-8")
print(payload)

"""
this is my super secret data
"""
```

---

## 参考
 - [Secret Manager のコンセプトの概要/cloud.google.com](https://cloud.google.com/secret-manager/docs/overview?hl=ja)

