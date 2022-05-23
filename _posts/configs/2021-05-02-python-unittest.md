---
layout: post
title: "pythonのunittest"
date: 2021-05-02
excerpt: "pythonのunittestについて"
tags: ["unittest", "python"]
config: true
comments: false
sort_key: "2022-05-20"
update_dates: ["2022-05-20"]
---

# pythonのunittestについて

## 概要
 - 標準モジュールの`unittest`でそこそこテストできる  
 - モックの機能もある

---

## unittestの実行

### ディレクトリ構造

```console
$ tree -I "*.pyc|__pycache__"
.
├── foo
│   ├── __init__.py
│   └── myfunc.py
└── tests
    ├── __init__.py
    └── test_foo.py
```
 - `tests/__init__.py`で`foo`のパスを追加する

***myfunc.py***
```python
import math
def my_add(a,b):
    return a + b + 1

def my_devide(a,b):
    if b == 0:
        return a/math.inf
    else:
        return a/b
```

***test_foo.py***
```python
import foo
import unittest

class TestFoo(unittest.TestCase):
    def test_myadd(self):
        self.assertEqual(foo.my_add(1,1), 3)
    def test_mydevide(self):
        self.assertEqual(foo.my_devide(10,0), 0)

if __name__ == "__main__":
    unittest.main()
```
 
### テストの実行
トップディレクトリで以下のコマンドを打つ
 - `discover`オプションで`tests`ディレクトリ以下のファイルをまとめて実行

***成功ケース***
```console
$ python3 -m unittest discover tests
..
----------------------------------------------------------------------
Ran 2 tests in 0.000s

OK
```

***失敗ケース***
```console
$ python3 -m unittest discover tests
.F
======================================================================
FAIL: test_mydevide (test_foo.TestFoo)
----------------------------------------------------------------------
Traceback (most recent call last):
    self.assertEqual(foo.my_devide(10,0), -1)
AssertionError: 0.0 != -1

----------------------------------------------------------------------
Ran 2 tests in 0.000s

FAILED (failures=1)
```

---

## モックを使用する例

### 概要
 - 複雑な関数やクラスの実態を定義したり呼び出したりすることなく、ダミーのreturn valueを与えるもの
 - モジュールが密に結合しているよう場合、切り離すのに使える

### モックを利用したreturn valueの書き換え

```python
class Foo:
    def __init__(self):
        ...
    def get(self, name):
        return "hello, " + name

foo = Foo()
assert foo.get("world") == "hello, world"

from unittest.mock import MagicMock
foo.get = MagicMock()
foo.get.return_value = "this is mock value"

assert foo.get("word") == "this is mock value"
```

## 参考
 - [unittest — Unit testing framework](https://docs.python.org/3/library/unittest.html)

