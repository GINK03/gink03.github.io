---
layout: post
title: "python ruamel.yaml"
date: 2025-08-17
excerpt: "python ruamel.yamlの使い方"
config: true
tag: ["python", "ruamel.yaml"]
comments: false
sort_key: "2025-08-17"
update_dates: ["2025-08-17"]
---

# python ruamel.yamlの使い方

## 概要
 - `ruamel.yaml`は、PythonでYAMLファイルを読み書きするためのライブラリ
 - [/python-pyyaml/](/python-pyyaml/)より高機能で細かい制御が可能
 - コメントやキー順序、アンカーなどを保持したまま編集できる（ラウンドトリップ）

## インストール

```console
$ pip install ruamel.yaml
```

## 読み込みと書き込み（基本）

```python
from ruamel.yaml import YAML
import io

yaml = YAML()  # 既定は round-trip（コメントや順序を保持）

doc = {
    "name": "my-app",
    "version": "1.0.0",
    "features": ["api", "web"],
}

buf = io.StringIO()
yaml.dump(doc, buf)
print(buf.getvalue())
"""
name: my-app
version: 1.0.0
features:
  - api
  - web
"""
```

## コメントや順序を保持したラウンドトリップ編集

```python
from ruamel.yaml import YAML
import io

yaml_text = """
# アプリ設定
name: my-app   # コメントは保持される
features:
  - api
  - web
"""

yaml = YAML()
data = yaml.load(io.StringIO(yaml_text))

# 値を変更・追加
data["name"] = "my-awesome-app"
data["features"].append("cli")

out = io.StringIO()
yaml.dump(data, out)
print(out.getvalue())
"""
# アプリ設定
name: my-awesome-app   # コメントは保持される
features:
  - api
  - web
  - cli
"""
```

## 細かいフォーマットの制御

```python
import sys
import io
from ruamel.yaml import YAML
yaml = YAML()
# YAMLの設定
yaml.indent(mapping=2, sequence=4, offset=2)
yaml.width = 88  # 行の折り返し幅

user_record = {
    "user_id": 101,
    "username": "alice",
    "profile": {
        "email": "alice@example.com",
        "active": True
    },
    "roles": ["editor", "viewer"],
    "permissions": [
        {"resource": "articles", "actions": ["read", "write"]},
        {"resource": "comments", "actions": ["read"]},
    ]
}

ss = io.StringIO()
yaml.dump(user_record, ss)
print(ss.getvalue())
"""
user_id: 101
username: alice
profile:
  email: alice@example.com
  active: true
roles:
  - editor
  - viewer
permissions:
  - resource: articles
    actions:
      - read
      - write
  - resource: comments
    actions:
      - read
"""
```

## スカラ文字列のスタイル（改行の保持や引用）

```python
from ruamel.yaml import YAML
from ruamel.yaml.scalarstring import (
    LiteralScalarString,        # | のリテラルブロック
    FoldedScalarString,         # > の折り畳みブロック
    DoubleQuotedScalarString,   # "..."
)
import io

yaml = YAML()
doc = {
    "literal": LiteralScalarString("line1\nline2\n"),
    "folded": FoldedScalarString("a long line that will be folded\ninto a single paragraph"),
    "json": DoubleQuotedScalarString('{"a": 1, "b": 2}')
}

buf = io.StringIO()
yaml.dump(doc, buf)
print(buf.getvalue())
"""
literal: |
  line1
  line2
folded: >-
  a long line that will be folded into a single paragraph
json: "{\"a\": 1, \"b\": 2}"
"""
```

## マルチドキュメントの読み込み・書き出し

```python
from ruamel.yaml import YAML
import io

yaml_text = """
---
env: dev
---
env: prod
"""

yaml = YAML()
docs = list(yaml.load_all(io.StringIO(yaml_text)))
assert docs == [{"env": "dev"}, {"env": "prod"}]

out = io.StringIO()
yaml.dump_all(docs, out)
print(out.getvalue())
"""
---
env: dev
---
env: prod
"""
```

## ファイルから読み書き（UTF-8）

```python
from ruamel.yaml import YAML

yaml = YAML()

with open("config.yaml", "r", encoding="utf-8") as rf:
    data = yaml.load(rf)

# 変更を加える
data["enabled"] = True

with open("config.yaml", "w", encoding="utf-8") as wf:
    yaml.dump(data, wf)
```

## 参考
 - より軽量でシンプルな用途は [/python-pyyaml/](/python-pyyaml/) も検討
