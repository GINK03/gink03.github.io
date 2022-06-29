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

---

## gcsfsによるファイルの読み書き

### 概要
 - アクセス権は`GOOGLE_APPLICATION_CREDENTIALSの環境変数`, `~/.config/gcloud/`の順で参照される
 - pythonの`read`, `write`関数のように扱える

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

### 参考
 - [/gcsfs.readthedocs.io/](https://gcsfs.readthedocs.io/en/latest/index.html)

---

## 参考
 - [静的ウェブサイトをホストする/docs](https://cloud.google.com/storage/docs/hosting-static-website)
