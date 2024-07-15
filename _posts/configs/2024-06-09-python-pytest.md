---
layout: post
title: "python pytest"
date: 2024-06-09
excerpt: "python pytestの使い方"
project: false
config: true
tag: ["python", "pytest"]
comments: false
sort_key: "2024-06-09"
update_dates: ["2024-06-09"]
---

# python pytestの使い方

## 概要
 - pythonのテストフレームワーク
 - `pytest.ini`ファイルにパスを設定することで、テスト対象のファイルを指定できる
 - 標準出力はデフォルトでは表示されないが、`-s`オプションをつけることで表示できる

## インストール

```console
$ pip install pytest
```

## ファイル構成例

```console
project/
│
├── src/
│   ├── __init__.py
│   └── my_module.py
│
├── tests/
│   ├── __init__.py
│   ├── conftest.py  # ここに sys.path.insert を追加
│   └── test_my_module.py
│
└── pytest.ini  # ここに pythonpath を追加する場合
```

**pytest.ini**
 - テスト対象のディレクトリの指定
 - テスト対象のファイル名の指定

```ini
# pytest.ini
[pytest]
pythonpath = src
testpaths = tests
python_files = test_*.py tests_*.py
```

**src/my_module.py**

```python
def add(a, b):
    return a + b
```

**tests/test_my_module.py**

```python
from my_module import add

def test_add():
    assert add(1, 2) == 3
```

## 実行

**すべてのテストを実行**

```console
$ pytest
```

**特定のテストを実行**
 - `::<関数名>`で実行するテストを指定できる

```console
$ pytest tests/test_my_module.py::test_add
```

## トラブルシューティング

### pytestを実行してもテストが実行されない
 - 原因
   - `tests/__init__.py`が存在しない
   - `pytest.ini`に記されている`python_files`に一致していないテストファイル名になっている
