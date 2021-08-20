---
layout: post
title: "nextcloud"
date: 2021-08-20
excerpt: "nextcloudの使い方"
tags: ["nextcloud"]
config: true
comments: false
---

# nextcloudの使い方

## 概要
 - dropbox + google docのオンプレミス版
 - 簡単に構築できるので少人数、スモールオフィス的な用途では便利に使える

## セットアップ

```console
$ mkdir nextcloud apps config data
$ docker run -d \
    -v $PWD/nextcloud:/var/www/html \
    -v $PWD/apps:/var/www/html/custom_apps \
    -v $PWD/config:/var/www/html/config \
    -v $PWD/data:/var/www/html/data \
    -p 8080:80 nextcloud
```

**管理者を作成**  
 - `http://hostname:8080`にアクセスする

## 信頼するドメインを追加する
セットアップ時のドメインと異なったドメインでアクセスするとエラーが起きるので、`nextcloud/config/config.php`を編集する

```php
'trusted_domains' =>
  array (
    0 => '192.168.0.29',
    1 => 'cloud.example.com',
  ),
```
 - リスト表記する
 - [参考](https://help.nextcloud.com/t/howto-add-a-new-trusted-domain/26)


## dockerをサービス化する
`/etc/systemd/system/docker.nextcloud.service`を作成する  
ファイルを以下のように埋める  
```config
[Unit]
Description=Nextcloud Service
After=docker.service
Requires=docker.service

[Service]
TimeoutStartSec=0
Restart=always
ExecStartPre=/usr/bin/docker pull nextcloud
ExecStart=/usr/bin/docker run -d \
    -v <PATH>/nextcloud:/var/www/html \
    -v <PATH>/apps:/var/www/html/custom_apps \
    -v <PATH>/config:/var/www/html/config \
    -v <PATH>/data:/var/www/html/data \
    -p 8080:80 \
    nextcloud

[Install]
WantedBy=default.target
```

サービスとして実行・登録する  
```console
# systemctl start docker.nextcloud
# systemctl enable docker.nextcloud
```
 - [参考](https://www.jetbrains.com/help/youtrack/standalone/run-docker-container-as-service.html)
