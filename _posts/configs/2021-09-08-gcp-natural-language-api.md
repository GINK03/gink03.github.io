---
layout: post
title: "gcp natural language api"
date: 2021-09-08
excerpt: "gcp natural language apiについて"
tags: ["cloud build", "gcp", "api"]
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

## 日本語のセンチメント分析の例

**コード**  
 - [gist](https://gist.github.com/GINK03/2a22e4432ac8d489997f86a0970e603e)

**出力**  

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
