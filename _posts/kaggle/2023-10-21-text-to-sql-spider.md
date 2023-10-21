---
layout: post
title: "Text-to-SQL Spider"
date: 2023-10-21
excerpt: "Text-to-SQL Spiderについて"
project: false
kaggle: true
tag: ["NLP", "Kaggle", "Text-to-SQL"]
comments: false
sort_key: "2023-10-21"
update_dates: ["2023-10-21"]
---

# Text-to-SQL Spiderについて

## 概要
 - [Text-to-SQL Spider](https://yale-lily.github.io/spider)は、自然言語の質問文からSQL文を生成するタスク
 - コンペティション形式になっており、Spiderデータセットを用いてモデルの性能を定量化している
   - ソリューションも公開されており、モデルの構築に役立つ

## Spiderデータセット
 - [Spider](https://yale-lily.github.io/spider)にて公開されている
   - Google Driveにてダウンロード可能

### データセットの構成
 - `train.json` : 学習用データ
 - `dev.json` : 検証用データ
 - `tables.json` : テーブル情報

### データセットのフォーマット
 - `train.json`と`dev.json`は以下のようなフォーマットになっている
   - `question` : 質問文
   - `sql` : SQL文
   - `db_id` : テーブル情報のID
