---
layout: post
title: "Backblaze(B2)"
date: 2022-04-25
excerpt: "Backblaze(B2)の使い方"
project: false
config: true
tag: ["backblaze", "b2", "s3"]
comments: false
---

# Backblaze(B2)の使い方

## 概要
 - S3互換プロトコルのオブジェクトストレージ
   - S3関連のツールが使えると思いきや、たまにエラーが出たりするので、完全にAWSの仕様にキャッチアップしているわけではなさそうである
 - 価格が安いことがとにかく売りである
   - GoogleDriveやOneDriveよりはるかに安価であるのでBackblazeを契約したほうがよい
 - 一日に使える金額のキャップをすることが可能であり、操作ミスやDoS攻撃や大量のアクセスでのエグレス料金による破産を防げる

## B2の各機能の解説
 - `Buckets`
   - バケットの新規作成
   - 既存のバケットのパラメータの確認
 - `Browse Files`
   - バケットの中を参照する
 - `Reports`
   - 保存されているデータ量、エグエス、トランザクション数のレポート
 - `Caps & Alerts`
   - 各課金指標に対してキャップを設定できる
     1. `Daily Storage Caps`
     2. `Daily Download Bandwidth Caps`
     3. `Daily Class B Transactions Caps`
     4. `Daily Class C Transactions Caps`
 - `App Keys`
   - バケットにアクセスするためのキーを発行管理する

## 各OSからB2バケットをマウントできるツール
 - Windows
   - [/mountainduck/](/mountainduck/)
 - OSX
   - [/mountainduck/](/mountainduck/)
   - [/rclone/](/rclone/)
 - Linux
   - [/rclone/](/rclone/)
