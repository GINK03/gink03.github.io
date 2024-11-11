---
layout: post
title: "minio server"
date: 2017-10-21
excerpt: "minio serverの使い方"
tags: ["minio", "s3"]
sort_key: "2018-01-19"
update_dates: ["2022-05-30", "2018-01-19"]
config: true
comments: false
---

# minio

## 概要
 - S3互換のバケットの管理システムでオンプレで動作させられるソフトウェア
 - [/mountainduck/](/mountainduck/)を利用することでファイルシステムとしてマウントでき、プライベートクラウドとして運用が可能である
 - 専用の`mc`というクライアントソフトウェアも提供している
 - S3にデータを保存できるlitestreamのバックエンドとしても使用可能

## install

**goコマンドを用いる**  
```console
$ go install github.com/minio/minio@latest
```

**バイナリを直接ダウンロードする**  
```console
$ wget https://dl.min.io/server/minio/release/linux-amd64/minio
$ chmod +x minio
```

## config
 - `~/.minio/config.json`を作成し、そこに記述する

```json
{
    "version": "1",
    "credential": {
        "accessKey": "<username>",
        "secretKey": "<password>"
    },
    "region": "us-east-1",
    "browser": "on"
}
```

## serverの起動

```console
$ minio server <target-directory>/ --address ":9000" --console-address ":9001"
```

## サービスの作成

**~/.config/systemd/user/minio.service**  
```ini
[Unit]
Description=MinIO Server
After=network.target

[Service]
ExecStart=minio server %h/minio
WorkingDirectory=%h
Environment="MINIO_CONFIG_DIR=%h/.minio"
Restart=always

[Install]
WantedBy=default.target
```

## 参考
 - [MinIO Quickstart Guide](https://docs.min.io/docs/minio-quickstart-guide.html)
 - [How to use Mountain Duck with Minio](https://github.com/astaxie/cookbook/blob/master/docs/how-to-use-mountainduck-with-minio.md)
   - `http`プロトコルのS3プラグインを入れるとマウントできる
