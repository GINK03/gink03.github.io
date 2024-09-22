---
layout: post
title: "obsidian-livesync"
date: 2024-09-22
excerpt: "obsidian-livesyncの使い方"
config: true
tag: ["markdown", "obsidian", "livesync"]
comments: false
sort_key: "2024-09-22"
update_dates: ["2024-09-22"]
---

# obsidian-livesyncの使い方

## 概要
 - CouchDBを使ったObsidianの同期ツール
 - macOS, iOS両方に対応しているがiOSで使用するにはhttps化が必要

## サーバのセットアップ

**CouchDBの設定(local.ini, 不要な可能性がある)**
```ini
[couchdb]
single_node=true
max_document_size = 50000000

[chttpd]
require_valid_user = true
max_http_request_size = 4294967296

[chttpd_auth]
require_valid_user = true
authentication_redirect = /_utils/session.html

[httpd]
WWW-Authenticate = Basic realm="couchdb"
enable_cors = true

[cors]
origins = app://obsidian.md,capacitor://localhost,http://localhost
credentials = true
headers = accept, authorization, content-type, origin, referer
methods = GET, PUT, POST, HEAD, DELETE
max_age = 3600
```

**CouchDBの実行**
```console
$ docker run --name couchdb-for-ols -d --restart always \
        -e COUCHDB_USER=${username} \
        -e COUCHDB_PASSWORD=${password} \
        -v ${PWD}/local.ini:/opt/couchdb/etc/local.ini
        -v ${PWD}/couchdb-data:/opt/couchdb/data \
        -v ${PWD}/couchdb-etc:/opt/couchdb/etc/local.d \
        -p 5984:5984 couchdb
```

**Caddyの設定(CouchDBのhttps化)**
```caddy
xxxxx.duckdns.org:5985 {
    reverse_proxy localhost:5984
}
```

**Caddyの実行**
```console
$ sudo caddy run --config ./Caddyfile
```

## クライアントのセットアップ
 - community pluginのインストール
 - 各種設定を行う 

### おすすめのクライアントの設定
 - livesyncモードは不安定なので、periodicとeventで保存
 - hidden fileの共有はやめておく
 - 最初の1台には頑張ってセットアップして、`Copy current setting URI...`みたいなので、別のコンピュータに設定を反映
 - 同期が始まらない場合はmaintainanceモードから、`fetch w/o restarting`を試す
