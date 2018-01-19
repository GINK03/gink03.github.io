---
layout: post
title: "TreasureData dump to S3"
date: 2017-07-26
excerpt: "TreasureData dump to S3."
tags: [treasuredata]
config: true
comments: false
---

# TreasureDataの内容をダンプする

いつの頃からか、Treasure Dataから100GByteを超えるようなタスクができなくなってしまった  

データの直列化には大量のデータをダンプする必要があり、通常の方法ではできないので、詳細を示す

## アプローチ
table丸ごとS3ダンプするアプローチである  

S3にダンプすることで、EMRないし、類似した手法にて分析ができる　

## S3の設定
S3のバケットにもリージョンが存在しており、　バージニア州のS3である必要がある  
また、S3は標準では、IPアクセス制限などがなく、APIキーを使えば自由にアクセスできる  
ここで、任意のS3バケットを作っておき、フォルダを作っておく  
この時のバケットめいを{$NAME}、フォルダ名を{$FOLDER}とする  

## TDコマンドのインストール　
TD（ツールベルトとも呼ばれる）は、ubuntuではこのようにインストールできる　　

Debian系では以下のコマンド
```console
$ curl -L https://toolbelt.treasuredata.com/sh/install-ubuntu-trusty-td-agent2.sh | sh
```

RHEL系では以下のコマンド
```console
$ curl -L https://toolbelt.treasuredata.com/sh/install-redhat-td-agent2.sh | sh
```

tdのアップデート　　　

Ruby Gemが実態らしいので、これでいける（はず）  
```console
$ sudo td-agent-gem update
```

## dump command
シェルスクリプトにこれらをまとめて実行するだけである　　
各変数は、実態に合わせて書き換えること
```console
td table:export {$DATABASE} {$TABLE} \
   --s3-bucket {$NAME} \
   --prefix {$FOLDER} \
   --aws-key-id {$AWS_KEY} \
   --aws-secret-key {$AWS_SECRET_KEY} \
   --file-format jsonl.gz
```
