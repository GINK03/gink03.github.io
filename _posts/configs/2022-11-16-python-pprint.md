---
layout: post
title: "python pprint"
date: "2022-11-16"
excerpt: "python pprintの使い方"
config: true
tag: ["python", "pprint"]
comments: false
sort_key: "2022-11-16"
update_dates: ["2022-11-16"]
---

# python pprintの使い方

## 概要
 - pythonのpritty print
   - 標準出力に出力時に整形して出力する
 - jsonでシリアライズできない型なども可視化して確認することができるので便利 

## 具体例

```python
import numpy as np
import pandas as pd

pp = pprint.PrettyPrinter(indent=2, width=120, depth=6)
data = [np.nan, pd.NaT, None, ""]
pp.pprint(data)

"""
[nan, NaT, None, '']
"""
```

## Colab
 - [pprint-example](https://colab.research.google.com/drive/1J2nxinocX8QkbEh9fb4-AiyyioCB5mtu?usp=sharing)

---

## 参考
 - [pprint — Data pretty printer](https://docs.python.org/3/library/pprint.html)

