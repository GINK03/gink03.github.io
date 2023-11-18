---
layout: post
title: "python csv"
date: "2022-05-21"
excerpt: "python csvの使い方"
project: false
config: true
tag: ["python", "csv"]
comments: false
sort_key: "2022-05-21"
update_dates: ["2022-05-21"]
---

# python csvの使い方

## 概要
 - `csv`というcsvファイルをハンドルするためのモジュールがある
 - pandasで操作してしまうほうが簡単であるが、pandasが導入できないときなどに使用できる

## 型推論に失敗するケース
 - XのIDのような大きい整数値があるとき、floatになってしまう
   - dtype引数で明示的に型を指定する必要がある

```python
import pandas as pd
df = pd.read_csv("x_sample.csv", dtype={"id": int})
```

## 具体例

### csvファイルを読み込む

```python
from io import StringIO

csv_string = """Spark,25000,50 Days,2000
Pandas,20000,35 Days,1000
Java,15000,,800
Python,15000,30 Days,500
PHP,18000,30 Days,800"""

import csv
with StringIO(csv_string) as fp:
    reader = csv.reader(fp) # filehandlerを引数に初期化
    for row in reader:
        print(row)

"""
['Spark', '25000', '50 Days', '2000']
['Pandas', '20000', '35 Days', '1000']
['Java', '15000', '', '800']
['Python', '15000', '30 Days', '500']
['PHP', '18000', '30 Days', '800']
"""
```

### csvファイルに書き出す

```python
import pandas as pd
import random

# 適当なデータを作る
df = pd.DataFrame()
df["a"] = [random.choice("abcdef") for i in range(10**3)]
df["b"] = [random.choice(range(10)) for i in range(10**3)]
df.reset_index(inplace=True)

with open("sample.csv", "w") as fp:
    writer = csv.writer(fp, delimiter="\t")
    for row in df.values.tolist():
        writer.writerow(row)
!head sample.csv
"""
0	b	4
1	d	0
2	b	7
3	a	4
4	e	0
5	b	8
6	f	1
"""
```

## Google Colab
 - [python-csv](https://colab.research.google.com/drive/1vtf7wT_jy53eGCGDtP5gEYX2vVY3kM7J?usp=sharing)

## 参考
 - [csv — CSV File Reading and Writing](https://docs.python.org/3/library/csv.html)
