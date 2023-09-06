---
layout: post
title: "jupyter itables"
date: 2023-09-06
excerpt: "jupyter itablesの使い方"
tag: ["jupyter", "kaggle", "python"]
comments: false
sort_key: "2023-09-06"
update_dates: ["2023-09-06"]
---

# jupyter itablesの使い方

## 概要
 - デフォルトのデータフレームの表示はペジネーションをサポートしない
 - itablesというライブラリでペジネーションが可能
 - デフォルトで1ページあたり10行になる

## インストール

```console
$ pip install itables
```

## 具体例

```python
import pandas as pd
import itables
from vega_datasets import data

df: pd.DataFrame = data.iris()

itables.show(df)
```

<div>
    <img src="https://f004.backblazeb2.com/file/gimpeik/Images/Screenshot+2023-09-06+at+13.42.47.png">
</div>

### Google Colab
 - [example-itables](https://colab.research.google.com/drive/1p2ypthJGJCarvwLBOXXV29EgmzGjnhc7?usp=sharing)

## 参考
 - [Interactive Tables](https://mwouts.github.io/itables/quick_start.html)
