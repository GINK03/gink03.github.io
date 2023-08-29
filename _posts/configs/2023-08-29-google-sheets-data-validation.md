---
layout: post
title: "Google Sheets Data Validation"
date: 2023-08-29
excerpt: "Google Sheets Data Validation(データの入力規則)の使い方"
config: true
tag: ["google sheets", "gss", "spreadsheets", "google spreadsheets", "data validation", "データの入力規則"]
comments: false
sort_key: "2023-08-29"
update_dates: ["2023-08-29"]
---

# Google Sheets Data Validation(入力規則)の使い方

## 概要
 - 英語表記では`Data Validation`, 日本語文献では`データの入力規則`と表現される

## 機能
 - `Dropdown`
 - `Dropdown(from a range)`
 - `Text contains`
 - `Text not contains`
 - `Date is`
 - `Date is before`
 - `Date is after`
 - `Date between`
 - `Greater than`
 - `Less than`
 - `Is equal to`
 - `Checkbox`

## 他のシートの内容を選択項目としてDropdownを作成する
 - `Data`を選択
 - `Criteria`から`Dropdown(from a range)`を選択
 - `<sheet-name>!<cell-start>:<cell-end>`
   - `A1:A`のような設定を行えば、あとから選択項目を追加できる
