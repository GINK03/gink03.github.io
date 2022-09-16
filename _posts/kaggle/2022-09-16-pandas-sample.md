---
layout: post
title: "pandas sample"
date: 2022-09-16
excerpt: "pandas sampleのチートシート"
kaggle: true
tag: ["python", "pandas", "sample", "チートシート"]
sort_key: "2022-09-16"
update_dates: ["2022-09-16"]
comments: false
---

# pandas sampleのチートシート

## 概要
 - データのサンプリング

## データのシャッフル
 - `frac`は何割をランダムサンプルで取り出すか、というオプション
 - `frac=1.0`ではすべてサンプルする
   - シャッフルされた状態になる

```python
df.sample(frac=1.0)
```

## グループごとのサンプリング
 - グループごとの最大数を指定できる
 - グループのデータが最大数に満たない場合、`replace=True`すると何度も同じ要素が出現することで、アップサンプリングできる

```python
df = df.groupby(by=["day"]).sample(n=50000, random_state=1, replace=True)
```


