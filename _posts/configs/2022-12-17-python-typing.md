---
layout: post
title: "python typing"
date: 2022-12-17
excerpt: "pythonのtyping"
tags: ["python", "python3", "typing"]
config: true
comments: false
sort_key: "2022-12-17"
update_dates: ["2022-12-17"]
---

# pythonのtyping

## 概要
 - python3の特定のバージョンから導入された型アノテーション
 - vscodeやpyrightなどのチェックツールで静的チェックができるようになる

## Union型
 - `python3.10`から`|`でUnionを指定できる
 - Unionとは`いずれかの型`ということ
 - 例では`List[int]`か`pd.Series`を入力で期待する場合

```python
from typing import List

def function(value: List[int] | pd.Series):
    pass
```

## Optional型
 - よくあるデザインパターンの一種
 - 例外を用いないで失敗したら`None`を返すなどのパターン

```python
from typing import Optional

def function(value: int) -> Optional[int]:
    if value == 0:
        return None
    return 10.0/value
```

## Literal型
 - `Literal`を使うことで特定の値のみを受け付けることができる
 - 簡易的なenumのような使い方ができる

```python
from typing import Literal

def process_color(color: Literal['red', 'green', 'blue']) -> str:
    if color == 'red':
        return 'You selected red.'
    elif color == 'green':
        return 'You selected green.'
    elif color == 'blue':
        return 'You selected blue.'
    else:
        # この部分にはLiteralで型指定されているため通常到達しません
        raise ValueError('Invalid color')

# 正しい値
print(process_color('red'))   # You selected red.
```

## Dict型とその派生
 - 以下のものが存在する
   - `typing.Dict`
   - `typing.DefaultDict`
   - `typing.OrderedDict`

## 参考
 - [typing — Support for type hints/docs.python.org](https://docs.python.org/3/library/typing.html)
