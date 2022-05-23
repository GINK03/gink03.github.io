---
layout: post
title: "cloud build"
date: 2021-04-20
excerpt: "cloud buildについて"
tags: ["cloud build", "gcp"]
config: true
comments: false
sort_key: "2021-06-19"
update_dates: ["2021-06-19"]
---

# cloud buildについて
 - dockerをクラウド上でbuildして`gcr.io`にpushする仕組み

## コマンドで実行する場合

```console
$ gcloud builds submit --tag gcr.io/${GOOGLE_CLOUD_PROJECT}/${CONTAINER_NAME}
```

## yamlを作成して実行する場合
 - `cloudbuild.yaml`というファイルを作成する

*具体例*
```yaml
steps:
 - name: 'gcr.io/cloud-builders/docker'
  args: [ 'build', '-t', 'gcr.io/$PROJECT_ID/quickstart-image', '.' ]
images:
 - 'gcr.io/$PROJECT_ID/quickstart-image'
```

*実行*
```console
$ gcloud builds submit --config cloudbuild.yaml
```

