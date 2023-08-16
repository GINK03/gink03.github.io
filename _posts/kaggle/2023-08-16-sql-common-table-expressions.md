---
layout: post
title: "Common Table Expressions"
date: 2023-08-16
excerpt: "Common Table Expressions(CTE)の対応状況とメリット"
tag: ["SQL", "BigQuery", "CTE", "Common Table Expressions"]
comments: false
sort_key: "2023-08-16"
update_dates: ["2023-08-16"]
---

# Common Table Expressions(CTE)の対応状況とメリット

## 概要
 - 最新のSQLite, MySQL(<8.0), OracleやBigQueryで使用できるwith句を使った構文のこと

## 使用する目的とメリット
 - 可読性
 - 再利用
 - 再帰的クエリ

## CTEが使えない場合の代替
 - 一時テーブル
 - ビュー
