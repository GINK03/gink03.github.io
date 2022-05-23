---
layout: post
title: "google data studio/data portal"
date: 2021-03-13
excerpt: "data studio/data portalについて"
tags: ["data studio", "data portal", "gcp"]
config: true
comments: false
sort_key: "2021-03-13"
update_dates: ["2021-03-13"]
---

# data studio/data portalについて

## 概要
bigqueryへ接続することが可能であり、様々な情報を可視化することができる  
タブローのようなものをイメージするとよい  
公開データセットを利用することができる  

## 作成したダッシュボード
 - [austinの犯罪ダッシュボード](https://datastudio.google.com/reporting/eb5e5944-e066-469a-a4c0-1eb5e7492f14)

## customクエリで可視化する
 1. `データを追加`をクリック
 2. `bigquery`を選択
 3. `カスタムクエリ` -> `課金先のプロジェクを選択` -> `クエリを入力`
 4. 必要ならば、データソース編集画面から名前を変える(デフォルトがbigqueryになり不便なので)
