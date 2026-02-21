---
layout: post
title: "GCP ADC 認証"
date: 2022-04-07
excerpt: "GCP Application Default Credentials ADC の使い方メモ"
project: false
config: true
tag: ["gcp", "google auth", "ADC"]
comments: false
sort_key: "2022-04-11"
update_dates: ["2022-04-07", "2022-04-11"]
---

# GCP ADC 認証のプラクティス

## 概要
 - GCP で Python や JS から API を利用するときの認証フローのメモ
 - サービスアカウント鍵を Docker イメージに含めるのは避けたい
   - `gcloud` の認証や ADC を使ってローカルの認証情報を参照する

## Application Default Credentials (ADC) の優先順位
 1. `GOOGLE_APPLICATION_CREDENTIALS` に設定された鍵ファイル
 2. OAuth2 で作成される `~/.config/gcloud/application_default_credentials.json`
 3. GCP 上のメタデータから得られる情報

## OAuth2で認証ファイルを出力する

```console
# デフォルトのスコープで認証ファイルを出力
$ gcloud auth application-default login
# 特定のスコープで認証ファイルを出力
$ gcloud auth application-default login --scopes=https://www.googleapis.com/auth/cloud-platform,https://www.googleapis.com/auth/bigquery,https://www.googleapis.com/auth/drive
```
すると `~/.config/gcloud/application_default_credentials.json` が作成される

これを Docker 等で使うときは以下のように認証ファイルを共有する

```console
$ docker run -it -v ~/.config/:/root/.config <container-name>
```
これは一般的な GCP を用いた Python スクリプトでも最初に参照される

## `CLOUDSDK_CONFIG` でプロジェクトごとに認証と設定をカプセル化する
 - `envrc` などで以下の環境変数を与える

```shell
# gcloud CLIのコンフィグとADCの出力先をカレントディレクトリ配下に指定
export CLOUDSDK_CONFIG="${PWD}/.gcloud_config"

# 各種GCPクライアントライブラリ向けにADCの参照パスを明示
export GOOGLE_APPLICATION_CREDENTIALS="${CLOUDSDK_CONFIG}/application_default_credentials.json"
```

## Python で ADC からクレデンシャルを得る

**google-auth のインストール**  

```console
$ python3 -m pip install google-auth
```

**credentials インスタンスを得る**  

```python
import google.auth
credentials, project_id = google.auth.default()
```
 - 環境変数の `GOOGLE_APPLICATION_CREDENTIALS` がセットされていると最初にそちらから読み取られる

### `GOOGLE_APPLICATION_CREDENTIALS` を優先しないようにする

```console
$ unset GOOGLE_APPLICATION_CREDENTIALS
```

## Docker コンテナ内で認証を通す

 - ローカル開発などに限定したとき
 - `/root` 部分は適宜変更

```console
$ docker run -v ~/.config/gcloud/:/root/.config/gcloud -p 8080:8080 -it <image-name>
```

## 参考
 - [google.auth package](https://google-auth.readthedocs.io/en/master/reference/google.auth.html)
 - [gcloud auth application-default login/Google Cloud](https://cloud.google.com/sdk/gcloud/reference/auth/application-default/login)
 - [Docker に対する認証の設定/Google Cloud](https://cloud.google.com/artifact-registry/docs/docker/authentication#gcloud-helper)
 - [GCP の Application Default Credentials を使った認証](https://blog.pokutuna.com/entry/application-default-credentials)
