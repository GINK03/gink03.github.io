---
layout: post
title: "pandas assign" 
date: 2025-10-30
excerpt: "pandas assign"
kaggle: true
tag: ["pandas", "dataframe"]
comments: false
sort_key: "2025-10-30"
update_dates: ["2025-10-30"]
---

# pandas assign

## 概要
 - pandasのDataFrameに新しい列を追加するためのメソッド

## 使い方

**基本的な使い方**
```python
import pandas as pd

df = pd.DataFrame({'名前': ['太郎', '花子', '次郎'], '点数': [455, 250, 495]})

# 点数からパーセンテージを計算
df = df.assign(割合=lambda x: (x['点数'] / 500 * 100))
df
"""
|    | 名前   |   点数 |   割合 |
|---:|:-------|-------:|-------:|
|  0 | 太郎   |    455 |     91 |
|  1 | 花子   |    250 |     50 |
|  2 | 次郎   |    495 |     99 |
"""
```

**groupbyと組み合わせて使用する例**
```python
import pandas as pd
import numpy as np

# サンプルデータ：複数店舗での果物の売上
sales_df = pd.DataFrame({
    'store': ['東京店', '東京店', '東京店', '東京店', '大阪店', '大阪店', '大阪店', '大阪店', '名古屋店', '名古屋店', '名古屋店', '名古屋店'],
    'product': ['みかん', 'りんご', 'なし', 'バナナ', 'みかん', 'りんご', 'なし', 'バナナ', 'みかん', 'りんご', 'なし', 'バナナ'],
    'quantity': [150, 80, 60, 120, 200, 95, 75, 140, 180, 70, 85, 110],
    'unit_price': [100, 200, 150, 80, 100, 200, 150, 80, 100, 200, 150, 80]
})


# assignで売上額を計算し、groupbyとaggで店舗別に集計
store_analysis = (
    sales_df.assign(
        revenue=lambda x: x['quantity'] * x['unit_price'],
        discount_price=lambda x: x['unit_price'] * 0.9
    )
    .groupby('store')
    .agg(
        total_quantity=('quantity', 'sum'),
        avg_quantity=('quantity', 'mean'),
        total_revenue=('revenue', 'sum'),
        max_revenue=('revenue', 'max'),
        min_revenue=('revenue', 'min'),
        product_count=('product', 'count'),
        avg_unit_price=('unit_price', 'mean')
    )
    .assign(
        avg_revenue_per_product=lambda x: x['total_revenue'] / x['product_count'],
        revenue_range=lambda x: x['max_revenue'] - x['min_revenue'],
        category=lambda x: np.where(x['total_revenue'] > 50000, '高売上', '標準売上')
    )
)

store_analysis
"""
| store    |   total_quantity |   avg_quantity |   total_revenue |   max_revenue |   min_revenue |   product_count |   avg_unit_price |   avg_revenue_per_product |   revenue_range | category   |
|:---------|-----------------:|---------------:|----------------:|--------------:|--------------:|----------------:|-----------------:|--------------------------:|----------------:|:-----------|
| 名古屋店 |              445 |         111.25 |           53550 |         18000 |          8800 |               4 |            132.5 |                   13387.5 |            9200 | 高売上     |
| 大阪店   |              510 |         127.5  |           61450 |         20000 |         11200 |               4 |            132.5 |                   15362.5 |            8800 | 高売上     |
| 東京店   |              410 |         102.5  |           49600 |         16000 |          9000 |               4 |            132.5 |                   12400   |            7000 | 標準売上   |
"""
```
