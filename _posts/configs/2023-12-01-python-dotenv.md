---
layout: post
title: "python dotenv"
date: 2023-12-01
excerpt: "pythonのdotenvの概要と使い方"
config: true
tag: ["python", "dotenv"]
comments: false
sort_key: "2023-12-01"
update_dates: ["2023-12-01"]
---

# pythonのdotenvの概要と使い方

## 概要
 - プロジェクトで管理している環境変数を簡単に管理するためのライブラリ
 - プロジェクトトップに`.env`ファイルを作成し、そこに環境変数をキーバリュー形式で記述すると反映される

## インストール

```console
$ pip install python-dotenv
```

## 使い方

### .envファイルの作成

```console
$ touch .env
$ cat "KEY=VALUE" > .env
```

### .envファイルの読み込み

```python
import os
from dotenv import load_dotenv
load_dotenv()
assert os.getenv("KEY") == "VALUE"
```

### 特定のパスの.envファイルを読み込む

```python
import os
from dotenv import load_dotenv
load_dotenv(dotenv_path="/path/to/.env")
assert os.getenv("KEY") == "VALUE"
```
