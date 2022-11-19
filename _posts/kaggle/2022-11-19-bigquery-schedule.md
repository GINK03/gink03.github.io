---
layout: post
title: "bigquery schedule"
date: 2022-11-17
excerpt: "bigquery scheduleの使い方"
tags: ["bq", "bigquery", "gcp", "schedule"]
kaggle: true
comments: false
sort_key: "2022-11-17"
update_dates: ["2022-11-17"]
---

# bigquery scheduleの使い方

## 概要
 - BigQueryのクエリを定期実行できる
 - 粒度はhourly, daily, weeklyなど
 - Lookerでは定期実行での加工や、副作用を貯める仕組みがないので、より高機能なことを行うには補助的に必要

## 具体的なユースケース
 - ミュータブルな今の状態しかわからないテーブルに対して毎日集計を行い結果を時間付きで貯めることで、わかりやすく表示する

## クエリをスケジュール登録する
 - WebUIからクエリエディタで編集
 - 期待する結果が得られたら、`SCHEDULE`のボタンを押す
   - `CREATE NEW SCHEDULED QUERY`を選択
   - スケジュールするクエリに名前をつける
   - 粒度を選択する
   - 出力先のデータセットとテーブルを指定
   - 上書きか、追加かを選択

## スケジュールされたクエリを編集する
 - WebUIの左側のコントロールパネルから`SCHEDULED QUERIES`を選択
  - 名前をつけたクエリを選択
  - `EDIT`から編集する
  - `SCHEDULE` -> `Update Scheduled Query`から時間粒度の変更が可能

---

## 参考
 - [BigQueryでスケジュールされたクエリを使ってみた/niandc.co.jp](https://www.niandc.co.jp/sol/tech/date20220620_2192.php)
