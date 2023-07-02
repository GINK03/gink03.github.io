---
layout: post
title: "apple iphone battery drain"
date: 2023-07-02
excerpt: "apple iphoneのバッテリードレインに対する対応"
project: false
config: true
tag: ["apple", "iphone", "ios"]
comments: false
sort_key: "2023-07-02"
update_dates: ["2023-07-02"]
---

# apple iphoneのバッテリードレインに対する対応

## 概要
 - 一部のアプリのバグによりバッテリードレインが発生することがある

## 確認
 - `設定` -> `バッテリー` -> `個別のアプリ` からアプリ別, 処理別で使用量を確認できる
   - バックグラウンド処理で大量の電力を消費しているアプリはここでわかる

## バックグラウンド処理を抑制する
 - `設定` -> `個別のアプリ` -> `Appのバックグラウンド更新`のチェックを外す
