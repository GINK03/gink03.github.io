---
layout: post
title: "python pathvalidate"
date: 2023-09-15
excerpt: "pathvalidateの概要と使い方"
config: true
tag: ["pathvalidate", "python"]
comments: false
sort_key: "2023-09-15"
update_dates: ["2023-09-15"]
---

# pathvalidateの概要と使い方

## 概要
 - posix pathなどを使用してファイルを保存しようとするときに適切なパス名・ファイル名かどうか判定したりサニタイズしたりできるライブラリ 

## インストール

```console
$ pip install pathvalidate
```

## 代表的な使用方法

### 判定

```python
from pathvalidate import validate_filename
from pathvalidate import validate_filepath

filename = "invalid:filename"
validate_filename(filename)  # 例外をスロー

filepath = "/path/to/invalid:filename"
validate_filepath(filepath)  # 例外をスロー
```

### サニタイズ

```python
from pathvalidate import sanitize_filename
from pathvalidate import sanitize_filepath

filename = "invalid:filename"
safe_filename = sanitize_filename(filename)
print(safe_filename)  # "invalidfilename"

filepath = "/path/to/invalid:filename"
safe_filepath = sanitize_filepath(filepath)
print(safe_filepath)  # "/path/to/invalidfilename"
```
