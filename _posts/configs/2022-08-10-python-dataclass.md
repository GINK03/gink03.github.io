---
layout: post
title: "python dataclass" 
date: "2022-08-10"
excerpt: "python dataclassの使い方"
config: true
tag: ["dataclass", "python"]
comments: false
sort_key: "2022-08-10"
update_dates: ["2022-08-10"]
---

# python dataclassの使い方

## 概要
 - scalaなどであるdataclassのpython版
 - namedtupleなどと異なり、mutableなデータを扱える
 - 型情報を埋め込めるので、デバッグが容易にったり、コード品質に貢献できる
 - dataclassには関数を追加できる
 - `asdict`でdict型に情報を変換できる

## 具体例

```python
from dataclasses import dataclass
from dataclasses import asdict

@dataclass
class Item:
    name: str
    price: float

    def total_cost(self) -> float:
        return self.unit_price * self.quantity_on_hand

item = Item(name="サラダ", price=194.2)
assert asdict(item) == {"name": "サラダ", "price": 194.2}
```

## 参考
 - [dataclasses/docs.python.org](https://docs.python.org/ja/3.10/library/dataclasses.html)
