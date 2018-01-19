---
layout: post
title:  "Tresure Data for new commers"
date:   2017-04-10
excerpt: "自分向け資料"
project: false
config: true
tag:
- tresuredata
comments: false
---

# TresureData for New commers.

## td commandのインストール
```sh
curl -L https://toolbelt.treasuredata.com/sh/install-ubuntu-trusty-td-agent2.sh | sh
```

## td commandのユーザ認証
```sh
td -e https://api.treasuredata.com account -f
```

## digdagのインストール
fu**!!!
```sh
$ sudo curl -o /usr/local/bin/digdag --create-dirs -L "https://dl.digdag.io/digdag-latest"
$ sudo chmod +x /usr/local/bin/digdag
```

## digdagの実行
```sh
digdag run foo_bar.dig
```

## digdagのフォーマット
```sh
timezone: UTC

_export:
  td:
    database: workflow_temp

+task1:
  td>: queries/download_recent_top10000.sql
  download_file: output_recent_20170411_300000000.csv
  engine: hive
```

## digdagがcallするsqlフォーマット
```sql
SELECT *
FROM dac_aonesync.audience_data
WHERE TD_TIME_RANGE (time, '2017-04-10', null, 'JST')
ORDER BY time DESC
LIMIT 100000000
```
