---
layout: post
title: "unittest"
date: 2021-05-02
excerpt: "pythonのunittestについて"
tags: ["unittest", "python"]
config: true
comments: false
---

# pythonのunittestについて
標準モジュールの`unittest`でそこそこテストできる  

## ディレクトリ構造

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
 
## テストの実行
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
  File "/home/gimpei/.tmp/test/tests/test_foo.py", line 8, in test_mydevide
    self.assertEqual(foo.my_devide(10,0), -1)
AssertionError: 0.0 != -1

----------------------------------------------------------------------
Ran 2 tests in 0.000s

FAILED (failures=1)
```

