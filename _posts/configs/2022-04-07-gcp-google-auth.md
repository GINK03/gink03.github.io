---
layout: post 
title: "GCP Google Auth(ADC)"
date: 2022-04-07
excerpt: "GCP Google Auth(ADC)のプラクティス"
project: false
config: true
tag: ["gcp", "google auth", "ADC"]
comments: false
---

# GCP Google Authのプラクティス

## 概要
 - GCPでpythonやjsなどから他のシステムを参照するときにどのようなフローで認証するのがよいのかプラクティスがある
 - 一般的に、サービスアカウントのクレデンシャル情報をdockerの中に入れたりするのはセキュリティ上よくない
   - gcloud 認証ヘルパーという機能を用いてクレデンシャル情報を入れたり、特定のpythonライブラリを用いる

## Application Default Credentials (ADC) の優先順位
 1. `GOOGLE_APPLICATION_CREDENTIALS`に設定された鍵フィアル
 2. OAuth2時に出力された`~/.config/gcloud/applicstion_default_credentials.json`のファイル
 3. GCP上のメタデータから得られた情報

## OAuth2で認証ファイルを出力する

```console
$ gcloud auth application-default login
```
すると`~/.config/gcloud/applicstion_default_credentials.json`が得られる

これをdocker等で使うときは以下のように認証ファイルを共有する
```console
$ docker run -it -v ~/.config/:/root/.config <container-name>
```

## pythonでADCからクレデンシャル情報を得る

**google-authのインストール**  
```console
$ python3 -m pip install google-auth
```

**credentialsインスタンスを得る**  
```python
import google.auth
credentials, project_id = google.auth.default()
```
 - 環境変数の`GOOGLE_APPLICATION_CREDENTIALS`がセットされていると最初にそちらから読み取られる
 
### GOOGLE_APPLICATION_CREDENTIALSを優先しないようにする

```console
$ unset GOOGLE_APPLICATION_CREDENTIALS
```

## dockerコンテナの内部で認証を通す
 - ローカル開発などに限定したとき
 - root部分は適宜変更

```console
$ docker run -v ~/.config/gcloud/:/root/.config/gcloud -p 8080:8080 -it <image-name>
```

## 参考
 - [google.auth package](https://google-auth.readthedocs.io/en/master/reference/google.auth.html)
 - [gcloud auth application-default login/Google Cloud](https://cloud.google.com/sdk/gcloud/reference/auth/application-default/login)
 - [Docker に対する認証の設定/Google Cloud](https://cloud.google.com/artifact-registry/docs/docker/authentication#gcloud-helper)
 - [GCP の Application Default Credentials を使った認証](https://blog.pokutuna.com/entry/application-default-credentials)
