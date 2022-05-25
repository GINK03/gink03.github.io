---
layout: post
config: true
title: "gcp cloud build"
date: 2021-04-20
excerpt: "gcp cloud buildについて"
tags: ["cloud build", "gcp"]
sort_key: "2021-06-19"
update_dates: ["2022-05-25", "2021-06-19"]
comments: false
---

# gcp cloud buildについて

## 概要
 - dockerをクラウド上でbuildして`gcr.io`にpushする仕組み
 - githubとも連携可能で、ソースコードのpush時などにイベントを紐付けてビルドすることもできる

## コマンドで実行する場合
 - `Dockerfile`が存在するディレクトリでコマンドを実行する

```console
$ gcloud builds submit --tag gcr.io/${GOOGLE_CLOUD_PROJECT}/${CONTAINER_NAME}
```

## yamlを作成して実行する場合
 - `cloudbuild.yaml`というファイルを作成する

**具体例**
```yaml
steps:
 - name: 'gcr.io/cloud-builders/docker'
 - args: [ 'build', '-t', 'gcr.io/$PROJECT_ID/quickstart-image', '.' ]
images:
 - 'gcr.io/$PROJECT_ID/quickstart-image'
```

**実行**
```console
$ gcloud builds submit --config cloudbuild.yaml
```

## 参考
 - [コマンドラインと API からビルドを開始する/Google Cloud](https://cloud.google.com/build/docs/running-builds/start-build-command-line-api)
 - [GitHub からのリポジトリのビルド/Google Cloud](https://cloud.google.com/build/docs/automating-builds/build-repos-from-github#gcloud)
