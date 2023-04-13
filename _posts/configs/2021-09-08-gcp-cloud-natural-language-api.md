---
layout: post
title: "gcp natural language api"
date: 2021-09-08
excerpt: "gcp natural language apiについて"
tags: ["nlp", "google cloud platform", "gcp", "api"]
config: true
comments: false
sort_key: "2022-04-05"
update_dates: ["2022-04-05","2022-02-24","2022-02-24"]
---

# gcp natural language apiについて

## できること
 - センチメント分析
 - ランドマーク
 - ランドマーク（センチメント）
 - シンタックス
 - 分類
 - クエリラベル（最も最適なクエリを提案）
 - 構文解析（係り受けを考慮した形態素解析）

## 料金
 - ドキュメント
   - [Cloud Natural Language の料金](https://cloud.google.com/natural-language/pricing?hl=ja)
 - ユニットという単位で課金される
   - 1ユニット1000文字
   - 1000ユニットで数ドル
 - 例えば、感情分析が1000ユニットあたり$1のとき、合計10120307文字を分析するとき
   - `10120307 / 1000 ≒  10120ユニット`
   - `10120ユニット / 1000 * $1 ≒  $10.12`

## サンプル
 - [公式サンプル](https://cloud.google.com/natural-language/docs/samples)

## インストール

```console
$ python3 -m pip install google-cloud-language
```

---

## 日本語のセンチメント分析の例

### 概要
 - 文字列のネガポジを判定する
 - 改行区切りや"。"で終わっている文を一つの文として見做しておらず、様々な箇所で区切られる
   - 文章全体について知りたい場合は、戻り値のメンバ変数の`response.document_sentiment`にアクセスする

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

---

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

---

## 日本語の構文解析

### 概要
 - 係り受けを考慮した形態素解析
 - 係り受けの関係がわかりやすい

### コード
 - [gist](https://gist.github.com/GINK03/2a22e4432ac8d489997f86a0970e603e#file-gcp-nlp-api-jp-koubun-py)

### 出力

```console
Language of the text: ja
Token text: ウクライナ
Location of this token in overall document: 0
Part of Speech tag: NOUN
Head token index: 4
Label: NN

Token text: の
Location of this token in overall document: 15
Part of Speech tag: PRT
Head token index: 0
Label: PRT

Token text: ゼレン
Location of this token in overall document: 18
Part of Speech tag: NOUN
Head token index: 3
Label: NN

Token text: スキー
Location of this token in overall document: 27
Part of Speech tag: NOUN
Head token index: 4
Label: NN

Token text: 大統領
Location of this token in overall document: 36
Part of Speech tag: NOUN
Head token index: 19
Label: NSUBJ

Token text: は
Location of this token in overall document: 45
Part of Speech tag: PRT
Head token index: 4
Label: PRT
...
```
