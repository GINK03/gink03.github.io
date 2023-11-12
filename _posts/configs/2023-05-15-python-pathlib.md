---
layout: post
title: "python pathlib"
date: 2023-05-15
excerpt: "pythonのpathlibの使い方"
config: true
tag: ["python", "pathlib"]
comments: false
sort_key: "2023-05-15"
update_dates: ["2023-05-15"]
---

# pythonのpathlibの使い方

## 概要
  - 低レイヤーであったファイルシステムをラップしたもの

## よく使う機能とメンバ変数
 - パス結合
   - `Path("directory") / "file"`
 - ファイル・ディレクトリのイテレータ
   - `Path("directory")`
 - ファイルの検索
   - `Path(".").glob("*.txt")`
 - ファイルの存在の有無
   - `Path("file").exists()`
 - ファイルの読み書き
   - `text = Path("file").read_text()`
   - `Path("file").write_text("foo bar")`
 - パスの絶対値を得る
   - `Path("file").resolve()`
 - ファイルサイズを得る
   - `Path("file").stat().st_size`
 - ディレクトリの作成
   - `Path("directory").mkdir(exist_ok=True)`
 - ファイルの作成
   - `Path("file").touch()`
 - ファイルの削除
   - `Path("file").unlink()`
 - シンボリックリンクの作成
   - `Path('path/to/symlink.txt').symlink_to(Path('path/to/original_file.txt'))`
 - ファイル名(拡張子付き)
   - `Path("path/to/file.txt").name` -> `file.txt`
 - ファイル名(拡張子なし)
   - `Path("path/to/file.txt").stem` -> `file`
