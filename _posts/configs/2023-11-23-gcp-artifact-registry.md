---
layout: post
title: "gcp artifact registry"
date: 2023-11-23
excerpt: "gcp artifact registry"
tags: ["gcp", "artifact registry", "gar"]
config: true
comments: false
sort_key: "2023-11-23"
update_dates: ["2023-11-23"]
---

# gcp artifact registry

## 概要
 - GCPの新しいコンテナレジストリ
 - Google Container Registryとの違いはアクセス範囲にある
   - GCRはプロジェクト単位でのアクセス制御
   - GARはリポジトリ単位でのアクセス制御
 - コンテナのスキャン機能があり、脆弱性のあるパッケージを検知できる

## GARのパスについて
 - `asia-northeast1-docker.pkg.dev/<project-id>/<repository>/<container>:<tag>`
   - `asia-northeast1`はリージョン
   - `docker.pkg.dev`はドメイン
   - `<project>`はGCPのプロジェクトID
   - `<path>/<to>`はイメージのパス

## Dockerの認証
 - `gcloud auth configure-docker asia-northeast1-docker.pkg.dev`
   - `asia-northeast1-docker.pkg.dev`に対してDockerの認証を行う
     - GCRの場合はリージョン・ドメインの指定が必要がないので注意

## リポジトリの作成
 - `gcloud artifacts repositories create <repository> --repository-format=docker --location=asia-northeast1`
   - `--repository-format=docker`でDockerイメージのリポジトリを作成
   - `--location=asia-northeast1`でリージョンを指定

## 参考
 - [Artifact Registry のドキュメント](https://cloud.google.com/artifact-registry/docs?hl=ja)
