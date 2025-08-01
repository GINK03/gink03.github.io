---
layout: post
title: "Backblaze(B2)"
date: 2022-04-25
excerpt: "Backblaze(B2)の使い方"
project: false
config: true
tag: ["backblaze", "b2", "s3"]
comments: false
sort_key: "2022-04-25"
update_dates: ["2022-04-25"]
---

# Backblaze(B2)の使い方

## 概要
 - S3互換プロトコルのオブジェクトストレージ
   - S3関連のツールが使えると思いきや、たまにエラーが出たりするので、完全にAWSの仕様にキャッチアップしているわけではなさそうである
 - 価格が安いことがとにかく売りである
   - GoogleDriveやOneDriveよりはるかに安価であるのでBackblazeを契約したほうがよい
 - 一日に使える金額のキャップをすることが可能であり、操作ミスやDoS攻撃や大量のアクセスでのエグレス料金による破産を防げる
 - アクセスログを特定のバケットに保存することができる
 - バケットの公開設定をすることで、画像やスタティックコンテンツの配信レポジトリとして使うことができる

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

## 画像やスタティックコンテンツの配信レポジトリとして使う
 - 公開設定にする
   - `Buckets` -> `Bucket Settings` -> `Public`に変更
 - Friendly URLを取得する
   - 共有したいファイルを選択し、詳細を表示するとFriendly URLが得られる

## `Master Application Key` とは
 - mountainduckなどでマウントする際に指定するIDとクレデンシャルのペアのこと
 - すべてのバケットが参照可能になるので管理に注意

## WebUIの操作
 - バケットを選択し、コンピュータからアップロードすることができる
   - このときファイルのソート機能がないので大量のファイルをアップロードする場合は注意が必要(vimium等で操作することをおすすめ)

## 各OSからB2バケットをマウントできるツール
 - macOS
   - [/mountainduck/](/mountainduck/)
   - [/rclone/](/rclone/)
 - Linux
   - [/rclone/](/rclone/)

