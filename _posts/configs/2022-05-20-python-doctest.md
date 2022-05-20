---
layout: post
title: "python doctest"
date: "2022-05-20"
excerpt: "python doctestの使い方"
project: false
config: true
tag: ["python", "doctest"]
comments: false
---

# python doctestの使い方

## 概要
 - pythonのdocstring内部に簡単なテストを記述できるもの
 - `>>> func_name(args...)\nvalue...`のような記述法
 - __main__でdoctestを呼び出すか、モジュールから呼び出すか、txtファイルから呼び出せる

## 具体例

### __main__で呼び出す場合

```python
def sample(a, b):
    """
    割り算の関数
    >>> sample(5, 2)
    2.5
    """
    return a/b

def sample2(a, b):
    """
    割り算の関数2
    >>> sample2(5, 2)
    2.5
    """
    return a*b

if __name__ == "__main__":
    import doctest
    doctest.testmod()
```
 - エラーとなった部分のみ表示される 

### モジュールから呼び出す

```console
$ python3 -m doctest sample-doctest.py 
**********************************************************************
Failed example:
    sample2(5, 2)
Expected:
    2.5
Got:
    10
**********************************************************************
1 items had failures:
   1 of   1 in sample-doctest.sample2
***Test Failed*** 1 failures.
```

## 参考
 - [doctest — Test interactive Python examples](https://docs.python.org/3/library/doctest.html)
 - エラーとなった部分のみ表示される
