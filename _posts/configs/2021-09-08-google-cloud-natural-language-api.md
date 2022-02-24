---
layout: post
title: "gcp natural language api"
date: 2021-09-08
excerpt: "gcp natural language apiについて"
tags: ["nlp", "google cloud platform", "gcp", "api"]
config: true
comments: false
---

# gcp natural language apiについて

## できること
 - センチメント分析
 - ランドマーク
 - ランドマーク（センチメント）
 - シンタックス
 - 分類
 - クエリラベル（最も最適なクエリを提案）

 - [公式サンプル](https://cloud.google.com/natural-language/docs/samples)

## インストール

```console
$ python3 -m pip install google-cloud-language
```

## 日本語のセンチメント分析の例

### 概要
 - 文字列のネガポジを判定する
 - 改行区切りや"。"で終わっている文を一つの文として見做しておらず、様々な箇所で区切られる

### コード
 - [gist](https://gist.github.com/GINK03/2a22e4432ac8d489997f86a0970e603e)

### 出力

```console
$ python3 gcp-nlp.py
Sentence text: 可能性という言葉を無限定に使ってはいけない。
Sentence sentiment score: -0.5
Sentence sentiment magnitude: 0.5
Sentence text: 我々という存在を規定するのは、我々がもつ可能性ではなく、我々がもつ不可能性である。
Sentence sentiment score: -0.5
Sentence sentiment magnitude: 0.5
Sentence text: ほんの些細な決断の違いで　私の運命は変わる。
Sentence sentiment score: -0.10000000149011612
Sentence sentiment magnitude: 0.10000000149011612
Sentence text: 無数の私が生まれる。
Sentence sentiment score: 0.0
Sentence sentiment magnitude: 0.0
Sentence text: 素晴らしい研究だと思う。
Sentence sentiment score: 0.8999999761581421
Sentence sentiment magnitude: 0.8999999761581421
Language of the text: ja
```

## 日本語のエンティティ分析

### 概要
 - エンティティ分析とは著名人やランドマークとなる単語を分析する
 - ランドマークがどのような係り受けを受けているか荒く把握できる

### コード
 - [gist](https://gist.github.com/GINK03/2a22e4432ac8d489997f86a0970e603e#file-gcp-nlp-api-jp-py)

### 出力

```console
$ python3 entities.py
Representative name for the entity: ロシア
Entity type: LOCATION
Salience score: 0.3528614938259125
mid: /m/06bnz
wikipedia_url: https://en.wikipedia.org/wiki/Russia
Mention text: ロシア
Mention type: PROPER
Mention text: ロシア
Mention type: PROPER
Representative name for the entity: 全土侵攻
Entity type: EVENT
Salience score: 0.1377442181110382
Mention text: 全土侵攻
Mention type: COMMON
Representative name for the entity: ウクライナ
Entity type: LOCATION
Salience score: 0.13067138195037842
...
```
