---
layout: post
title: "REST APIのベストプラクティス"
date: 2024-06-09
excerpt: "REST APIのベストプラクティスについて"
computer_science: true
tag: ["REST API", "プラクティス"]
comments: false
sort_key: "2024-06-09"
update_dates: ["2020-06-09"]
---

# REST APIのベストプラクティス

## 概要
 - リソース中心の設計
 - HATEOASを使用

## 各メソッドの使い分け
 - `GET` -  リソースの取得
 - `POST` - リソースの作成
 - `PUT` - リソースの更新
 - `DELETE` - リソースの削除

## リソース中心の設計

|       リソース      |           POST          |            GET            |                   PUT                   |           DELETE          |
|:-------------------:|:-----------------------:|:-------------------------:|:---------------------------------------:|:-------------------------:|
|          /customers | 新しい顧客を作成        | すべての顧客を取得        | 顧客を一括更新                          | すべての顧客を削除        |
|        /customers/1 | エラー                  | 顧客1の詳細を取得         | 顧客1の詳細を更新 (顧客1が存在する場合) | 顧客1を削除               |
| /customers/1/orders | 顧客1の新しい注文を作成 | 顧客1のすべての注文を取得 | 顧客1の注文を一括更新                   | 顧客1のすべての注文を削除 |

## 参考
 - [RESTful Web API の設計](https://learn.microsoft.com/ja-jp/azure/architecture/best-practices/api-design)
