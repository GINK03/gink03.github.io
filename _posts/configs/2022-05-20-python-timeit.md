---
layout: post
title: "python timeit"
date: "2022-05-20"
excerpt: "python timeitの使い方"
project: false
config: true
tag: ["python", "timeit"]
comments: false
sort_key: "2022-05-20"
update_dates: ["2022-05-20"]
---

# python pdbの使い方

## 概要
 - コードの実行時間を測定するモジュール
 - モジュールを指定してCLIからも実行できるし、jupyterの中でも使える
 - デフォルトの実行回数は`10*6回`


## CLIでコードの実行時間を測る

```console
$ python3 -m timeit '"-".join(map(str, range(100)))'
20000 loops, best of 5: 11.2 usec per loop
```

## pythonのコードの中で実行時間を測る

### lambdaをバイパスする方法
```python
import timeit
import random

def foo(x):
    return pow(x, random.choice([1, 2, 3, 4, 5]))

timeit.timeit(stmt=lambda :[foo(i) for i in range(10)]) # デフォルトのリピート数は 1000000
# 13.51418938200004

timeit.timeit(stmt=lambda :[foo(i) for i in range(10)], number=10) # リピート数を指定
# 0.00024423599961664877
```

### setupを使用する方法

```python
timeit.timeit(stmt="[foo(i) for i in range(10)]", setup="from __main__ import foo") # setupを使用する例
# 13.535947264999777
```
 - 名前空間から対象の関数をimportする

### Google Colab
 - [python-timeit](https://colab.research.google.com/drive/1izWQOtOjh-5klJHLLKGuYvYa45LY3Iqc?usp=sharing)

## 参考
 - [timeit — Measure execution time of small code snippets](https://docs.python.org/3/library/timeit.html)
