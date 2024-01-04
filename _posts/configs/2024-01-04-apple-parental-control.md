---
layout: post
title: "apple parental control" 
date: 2024-01-04
excerpt: "parental controlの設定方法"
tags: ["apple", "ios", "parental control"]
config: true
comments: false
sort_key: "2024-01-04"
update_dates: ["2024-01-04"]
---

# parental controlの設定方法

## 概要
 - Apple IDで設定した子供の端末に対して、親の端末から制限をかけることができる

## 設定可能な項目
 - アプリのインストール
 - アプリ内課金
 - ウェブサイトの閲覧
 - アプリの使用時間
 - ダウンタイム
 - コミュニケーションの安全性

## 具体的な設定
 - 親の端末で設定
   - 設定 -> `Screen Time` -> `子供の名前`

**ダウンタイムの設定**
 - 概要
   - 一時的にほとんどのアプリを使用できなくする
   - スケジュール設定か、親の端末から一時的に設定することができる
   - 反映には10分程度かかる
 - 設定 
   - `Downtime` -> `Turn On Downtime`

**アプリの使用時間の制限**
 - 概要
   - 一日の使用時間を制限する
 - 設定
   - `App Limits` -> `Add Limit` -> `All Apps & Categories` -> `Time` -> `Next` -> `Add`

**コミュニケーションの安全性**
 - 概要
   - 子供の端末で取られた写真や動画を(AppleのAIで)自動的に検閲する
   - ネットいじめやグルーミングを防ぐ
 - 設定
   - `Communication Safety` -> Turn On `Communication Safety`

**ウェブサイトの閲覧制限**
 - 概要
   - 親の端末で設定したウェブサイトのみ/以外を閲覧できる
 - 設定
   - アダルトサイトを制限
     - `Content & Privacy Restrictions` -> `Content Restrictions` -> `Web Content` -> `Limit Adult Websites`
   - 特定のサイトを制限/ブロック
     - `Content & Privacy Restrictions` -> `Content Restrictions` -> `Web Content`
       - `Never Allow` -> `Add Website` -> `https://example.com/`
