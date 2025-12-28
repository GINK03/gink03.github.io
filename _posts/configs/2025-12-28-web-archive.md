---
layout: post
title: "Web Archive"
date: 2025-12-28
excerpt: "Web Archiveの基本"
project: false
config: true
tag: ["webarchive", "Wayback Machine"]
comments: false
sort_key: "2025-12-28"
update_dates: ["2025-12-28"]
---

# Web Archiveの基本

## 概要
 - 「インターネットの図書館」としてデジタル文化遺産を半永久的に保存し、誰でもアクセス可能な状態を維持すること
 - マネタイズはLibrary as a Service (LaaS)モデルを採用し、寄付やサブスクリプションで運営
 - Wayback MachineのCDX APIを使うと、アーカイブ時刻やURLを機械的に取得できる

## 特定の記事の最古のバージョンを探す方法

**STEP 1. 特定のパスのURLの最古の日時を特定**
 - `limit=1`と`filter=statuscode:200`で最古の正常応答のみ取得
 - 戻り値の先頭列はUTCの`YYYYMMDDhhmmss`形式のタイムスタンプ

```console
$ curl -s "http://web.archive.org/cdx/search/cdx?url=www.iana.org/help/example-domains&limit=1&filter=statuscode:200&fl=timestamp,original"
230711115532 https://www.iana.org/help/example-domains
```

**STEP 2. 取得した日時を使ってアーカイブされたコンテンツを取得**
 - 1行目のタイムスタンプをそのまま埋め込む

```console
$ curl "http://web.archive.org/web/20230711115532/www.iana.org/help/example-domains"
```
