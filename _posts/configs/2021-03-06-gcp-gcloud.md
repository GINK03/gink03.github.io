---
layout: post
title: "gcloud"
date: 2021-03-06
excerpt: "gcloudについて"
tags: ["gcp", "gcloud"]
config: true
comments: false
sort_key: "2022-05-25"
update_dates: ["2022-05-25", "2022-05-17"]
---

# gcloudについて

## 概要
 - GCPのインフラストラクチャを設定するためのツール
 - コンポーネントと言われる粒度で機能を拡張することができる

## インストール

**ubuntu(snapを使用する場合)**  
```console
$ sudo snap install google-cloud-sdk --classic
```

**ubuntu, debian(aptにレポジトリを追加する場合)**  
```console
$ curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -
$ echo "deb https://packages.cloud.google.com/apt cloud-sdk main" | sudo tee -a /etc/apt/sources.list.d/google-cloud-sdk.list # apt-listに追加
$ sudo apt update
$ sudo apt install google-cloud-sdk
```

**osx**  
```console
$ brew install google-cloud-sdk
```
 - zshのオートコンプリートがバグることがあるのでその場合はシステム的に変更された`.zshrc`を戻す
 - caskでインストールされるとPATHが設定されないので、PATHを追加する
   - 一般には`/usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/bin`にバイナリがある
 - `PATH`が特殊なので注意  

```console
$(brew --prefix)/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/bin
```

**windows**  
```console
$ scoop install gcloud
```

## ユースケース毎の使い方

### アカウントのセットアップ

```console
$ gcloud init --skip-diagnostics
```

### 現在の設定を確認する

```console
$ gcloud info
```

### 複数の設定を使い分ける

#### 設定を作成する

```console
$ gcloud config configurations create <config-name>
```

#### 設定の一覧の確認

```console
$ gcloud config configurations list
```
 - すでに登録済みの設定の一覧を確認できる

#### 設定を有効化する

```console
$ gcloud config configurations activate <config-name>
```

### プロジェクトのセット

```console
$ gcloud config set project <project-name>
```

### 現在設定しているアカウントを切り替える
 1. `gcloud init`
 2. `[3] Switch to and re-initialize existing configuration: [default]`を選択
 3. 切り替え先のアカウントを選択
 4. 切り替え先のプロジェクトを選択

### iam-policyの確認

```console
$ gcloud projects get-iam-policy <project-name>
bindings:
- members:
  - serviceAccount:service-*******@compute-system.iam.gserviceaccount.com
  role: roles/compute.serviceAgent
- members:
  - serviceAccount:service-*******@containerregistry.iam.gserviceaccount.com
  role: roles/containerregistry.ServiceAgent
  ...
```

### コンポーネントのアップデート

```console
$ gcloud components update
```

---

## apiとの関係
 - `gcloud`コマンドは`API`をコマンドでラップしたものであるが、python等のスクリプトから呼び出す際は`google-api-python-client`を用いる  
 - 仕様が複雑で[ドキュメント](https://googleapis.github.io/google-api-python-client/docs/)を精読しないと使うことが難しい  

---

## トラブルシューティング

### gcloudのコマンドが反応しない
 - 原因
   - クレデンシャルがexpireしていることがある
 - 対応
   - 所属しているGCPによっては短時間でクレデンシャルexpireすることがあり、その度に再認証が必要
   - `gcloud auth login`を実行して再認証を行う
   - web browserがないマシンでは、web browserがあるマシンで実行してくれとのメッセージとともにURLとtokenが出力される
