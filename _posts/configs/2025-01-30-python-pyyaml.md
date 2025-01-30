---
layout: post
title: "python pyyaml"
date: 2025-01-30
excerpt: "python pyyamlの使い方"
config: true
tag: ["python", "pyyaml"]
comments: false
sort_key: "2025-01-30"
update_dates: ["2025-01-30"]
---

# python pyyamlの使い方

## 概要
 - yaml形式のファイルを読み込むためのライブラリ
 - ロードしたデータはdict型で取得でき、pydanticなどを使って型チェックを行うことができる

## インストール

```console
$ pip install PyYAML
```

## 読み込み

```python
from pydantic import BaseModel, ValidationError
import yaml
from typing import List

class AppConfig(BaseModel):
    ramen: List[str]
    curry: List[str]
    class Config:
        extra = "forbid"


yaml_text = """
ramen:
    - "チャーシュー麺"
    - "醤油ラーメン"
    - "味噌ラーメン"
curry:
    - "ポークカレー"
    - "ビーフカレー"
"""

config = yaml.safe_load(io.StringIO(yaml_text))
AppConfig(**config)
"""
AppConfig(ramen=['チャーシュー麺', '醤油ラーメン', '味噌ラーメン'], curry=['ポークカレー', 'ビーフカレー'])
"""
```
