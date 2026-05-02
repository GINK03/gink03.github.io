---
layout: post
title: "minio client mc"
date: 2017-10-21
excerpt: "MinIOクライアント mc の使い方"
tag: ["minio", "mc", "s3"]
sort_key: "2018-01-19"
update_dates: ["2022-05-30", "2018-01-19", "2026-05-02"]
config: true
comments: false
---

# MinIOクライアント mc の使い方

## 概要
 - MinIOおよびS3互換ストレージをCLIで操作するクライアントツール
 - `aws s3` コマンドに相当するが、MinIO・GCS・Azureなど複数のバックエンドに対応
 - エイリアスでプロファイルを管理し、`mc <コマンド> <エイリアス>/<パス>` の形式で操作する

## インストール

**goコマンド**
```console
$ go install github.com/minio/mc@latest
```

**macOS**
```console
$ brew install minio/stable/mc
```

**バイナリを直接ダウンロード（Linux）**
```console
$ wget https://dl.min.io/client/mc/release/linux-amd64/mc
$ chmod +x mc
$ sudo mv mc /usr/local/bin/
```

## エイリアスの設定

接続先をエイリアスとして登録する

```console
$ mc alias set <alias> <endpoint-url> <access-key> <secret-key>
```

登録例

```console
$ mc alias set local http://localhost:9000 minioadmin minioadmin
$ mc alias set prod https://s3.example.com AKIAIOSFODNN7 wJalrXUtnFEMI
```

登録済みエイリアスの一覧と確認

```console
$ mc alias list
$ mc alias list local
```

エイリアスの削除

```console
$ mc alias remove local
```

## 基本操作

### バケット操作

```console
$ mc mb local/my-bucket          # バケット作成
$ mc rb local/my-bucket          # バケット削除（空のみ）
$ mc rb --force local/my-bucket  # バケット削除（中身ごと）
$ mc ls local                    # バケット一覧
$ mc ls local/my-bucket          # バケット内オブジェクト一覧
$ mc ls --recursive local/my-bucket  # 再帰的に一覧表示
```

### ファイルのアップロード・ダウンロード

```console
$ mc cp file.txt local/my-bucket/           # ファイルをアップロード
$ mc cp local/my-bucket/file.txt ./         # ファイルをダウンロード
$ mc cp --recursive ./data/ local/my-bucket/data/  # ディレクトリごとアップロード
$ mc cp --recursive local/my-bucket/data/ ./data/  # ディレクトリごとダウンロード
```

### ミラーリング（同期）

ローカル↔ストレージ間の差分同期

```console
$ mc mirror ./data/ local/my-bucket/data/   # ローカル → ストレージに同期
$ mc mirror local/my-bucket/data/ ./data/   # ストレージ → ローカルに同期
$ mc mirror --watch ./data/ local/my-bucket/data/  # 変更を監視して継続同期
```

### ファイルの削除・移動

```console
$ mc rm local/my-bucket/file.txt            # ファイル削除
$ mc rm --recursive local/my-bucket/data/  # ディレクトリ以下を削除
$ mc mv local/my-bucket/a.txt local/my-bucket/b.txt  # リネーム・移動
```

### ファイルの確認・検索

```console
$ mc stat local/my-bucket/file.txt          # オブジェクトのメタデータ表示
$ mc find local/my-bucket --name "*.csv"    # 名前でオブジェクトを検索
$ mc find local/my-bucket --larger 100MB    # サイズでオブジェクトを検索
$ mc du local/my-bucket                     # バケットの使用量確認
```

### パイプ経由での読み書き

```console
$ mc cat local/my-bucket/file.txt           # ファイル内容を標準出力に表示
$ echo "hello" | mc pipe local/my-bucket/hello.txt  # 標準入力からアップロード
```

## ポリシー（公開設定）

```console
$ mc anonymous set download local/my-bucket      # バケットを読み取り公開
$ mc anonymous set none local/my-bucket          # 公開設定を解除（非公開に戻す）
$ mc anonymous get local/my-bucket               # 現在のポリシーを確認
```

## バケット間コピー（サーバーサイド）

同じエイリアス内または異なるエイリアス間でコピーできる

```console
$ mc cp local/src-bucket/file.txt local/dst-bucket/
$ mc mirror prod/src-bucket local/dst-bucket     # 別エンドポイント間の同期
```

## 参考
 - [MinIO Client Documentation](https://min.io/docs/minio/linux/reference/minio-mc.html)
