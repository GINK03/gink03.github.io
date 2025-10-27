---
layout: post
title: "zip/unzip と unar"
date: 2021-09-16
excerpt: "zip/unzip と unar の使い方と注意点"
tag: ["zip", "unzip", "linux", "macOS", "windows", "unar", "shift-jis", "文字化け", "解凍"]
config: true
comments: false
sort_key: "2022-04-08"
update_dates: ["2022-04-08","2022-01-03","2021-09-16"]
---

# zip/unzip と unar の使い方

## macOS / Linux での zip/unzip の基本

### zip ファイルの解凍（unzip）

```console
$ unzip <file.zip>
```

### ディレクトリをまとめて圧縮（zip）

```console
$ zip -r <out>.zip <dir-name>
```

### パスワード付きで圧縮

**インタラクティブにパスワードを入力する場合**  
```console
$ zip -e -r <out>.zip <filenames>
```

**パスワードを指定する場合**  
```console
$ zip -P <password> -r <out>.zip <filenames>
```

### unzip の便利なオプション

 - 一覧表示のみ: `unzip -l <file.zip>`
 - 展開先ディレクトリを指定: `unzip <file.zip> -d <out_dir>`
 - 既存ファイルを上書きしない: `unzip -n <file.zip>`

## macOS で Windows 作成の zip を解凍する
 - 日本語版 Windows は Shift_JIS の文字コードでファイル名を格納する場合があり、単純に `unzip` すると文字化けすることがある
 - `The Unarchiver` 由来の CLI ツール `unar` を用いると、文字コードを自動判別して文字化けせずに解凍できる

### インストール

**macOS**  
```console
$ brew install unar
```

**ubuntu, debian**  
```console
$ sudo apt install unar
```

### 解凍（unar）

```console
$ unar <file.zip>
```

## 参考
 - [macOS で zip 圧縮・展開するときの文字化け対処法](https://sekika.github.io/2016/03/25/MacZip/)
