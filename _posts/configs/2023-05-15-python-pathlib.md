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
 - ファイルの拡張子
   - `Path("file.txt").suffix` -> `.txt`
 - ファイルの親ディレクトリ
   - `Path("path/to/file.txt").parent` -> `path/to`
 - stat機能
   - ファイルサイズを得る
     - `Path("file").stat().st_size`
   - ファイルの更新日時を得る
     - `Path("file").stat().st_mtime`
   - ファイルの作成日時を得る
     - `Path("file").stat().st_ctime`
   - ファイルのアクセス日時を得る
     - `Path("file").stat().st_atime`
   - ファイルのパーミッションを得る
     - `Path("file").stat().st_mode`
   - ファイルの所有者を得る
     - `Path("file").stat().st_uid`
   - ファイルのグループを得る
     - `Path("file").stat().st_gid`
   - ファイルのデバイスを得る
     - `Path("file").stat().st_dev`
   - ctime, mtime, atimeはUNIXエポックからの秒数で返される
     - `datetime.fromtimestamp(Path("file").stat().st_mtime)`

## 具体的な使用例

### ファイルの更新日時でソートする

```python
from pathlib import Path
from datetime import datetime

for path in sorted(Path(".").glob("*"), key=lambda x: x.stat().st_mtime):
    print(path, datetime.fromtimestamp(path.stat().st_mtime))
```
