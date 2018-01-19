---
layout: post
title: "minio-server-client"
date: 2017-10-21
excerpt: "minio, server, client"
tags: [minio]
config: true
comments: false
---

# minioとは
S3互換のバケットの管理システムのでなんか便利なのも

## minio client

### Install
golangの1.8以上が望ましい

minio clinet mcのインストール
```console
$ go get github.com/minio/mc
$ go install github.com/minio/mc
```
PATHが通ってなかったら適宜、PATHを追加する

### configration
例えば、Ikazuchiサーバのminioに繋ぐ様に記憶させたい場合
```console
$ mc config host add ikazuchi http://192.168.15.16:9000 minio ${PASSWORD} S3v4
```

### 基本操作
Ikazuchiサーバを基準に説明します
backetの作成
```console
$ mc mb ikazuchi/${bucketName}
```
bucket一覧の確認
```console
$ mc ls ikazuchi
```
何かディレクトリの丸ごとコピー
```console
$ mc cp -r ${anyLocalDirectry} ikazuchi/${targetBucket}
```
publicにファイルを公開する
```console
$ mc policy download ikazuchi/${targetBucket} 
```

## minioサーバ
### install
```console
$ go get github.com/minio/minio
$ go install github.com/minio/minio
```
### config
.minioのディレクトリの内部にconfig.jsonを作成し、そこに記述します
```json
{
        "version": "19",
        "credential": {
                "accessKey": "minio",
                "secretKey": "YOUR_PASSWORD"
        },
        "region": "",
        "browser": "on",
        "logger": {
                "console": {
                        "enable": true 
                },
                "file": {
                        "enable": false,
                        "filename": ""
                }
        },
        "notify": {
        }
}
```
### serverの起動
```console
$ minio server ${TARGET_DIRECTRY}/ --address ":9001" 
```
