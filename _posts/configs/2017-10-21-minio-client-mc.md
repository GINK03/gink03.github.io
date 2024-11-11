---
layout: post
title: "minio client mc"
date: 2017-10-21
excerpt: "minio clinet mcの使い方"
tags: ["minio", "mc", "s3"]
sort_key: "2018-01-19"
update_dates: ["2022-05-30", "2018-01-19"]
config: true
comments: false
---

# minio client mcの使い方

## install

**goコマンドを利用する**  
```console
$ go install github.com/minio/mc@latest
```

**macOS**  
```console
$ brew install minio/stable/mc
```

**バイナリを直接ダウンロードする**  
```console
$ wget https://dl.min.io/client/mc/release/linux-amd64/mc
$ chmod +x mc
```

## configration

例えば、minioに繋ぐプロファイルを作成するとき
```console
$ mc alias set <profile-name> http://<address>:9000 <username> <password>
```

## 基本操作

### backetの作成

```console
$ mc mb <profile-name>/<bucket-name>
```

### bucket一覧の確認
```console
$ mc ls <profile-name>
```

### ディレクトリのコピー

```console
$ mc cp -r <any-local-directory> <profile-name>/<target-bucket>
```

### publicにファイルを公開する

```console
$ mc policy download <profile-name>/<target-bucket>
```
