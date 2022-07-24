---
layout: post
title: "Python nonlocal"
date: "2022-07-24"
excerpt: "Python nonlocalの使い方"
config: true
tag: ["python", "nonlocal"]
comments: false
sort_key: "2022-07-24"
update_dates: ["2022-07-24"]
---

# Python nonlocalの使い方

## 概要
 - 関数の中の関数を利用する際に、親関数の変数にアクセスする方法
 - globalはglobal変数にアクセスするという意味であるが、nonlocalは関数の外の変数にアクセスするという意味である
   - globalの替わりにはならない

## 具体例

**OKな例**  
```python
def func1():
    abc = 0
    def _func():
        nonlocal abc
        for i in range(0, 11):
            abc += i
    _func()
    assert abc == 55

func1()
```

**動作しない例**  
```python
def func2():
    abc = 0
    def _func():
        for i in range(0, 11):
            # 親関数の変数にはアクセスできない
            abc += i
    _func()
    print(abc)
```

## 参考
 - [Pythonのnonlocalとglobalの違い/Qiita](https://qiita.com/domodomodomo/items/6df1419767e8acb99dd7)
