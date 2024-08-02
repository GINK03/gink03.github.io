---
layout: post
title: "pandas rolling" 
date: 2024-08-02
excerpt: "pandasのrollingの使い方"
kaggle: true
tag: ["python", "pandas", "rolling", "チートシート"]
comments: false
sort_key: "2024-08-02"
update_dates: ["2024-08-02"]
---

# pandasのrollingの使い方

## 概要
 - pandasのrollingは、移動平均や移動合計などを計算する際に使用する

## rolling関数のオプション
 - `window` - 移動平均や移動合計を計算する際のウィンドウサイズ
 - `min_periods` - ウィンドウサイズに満たない場合の最小値(達さないとNaNを返す)
 - `center` - ウィンドウを中心にするかどうか
 - `win_type` - ウィンドウ関数を指定する

## サンプルコード

```python
import pandas as pd

# サンプルデータの作成
data = {'value': [1, 2, 3, 4, 5,]}
df = pd.DataFrame(data)

# デフォルト(center=False)で移動平均を計算
df['rolling_mean_default'] = df['value'].rolling(window=3).mean()

# center=Trueで移動平均を計算
df['rolling_mean_center'] = df['value'].rolling(window=3, center=True).mean()

df['rolling_mean_center_min_periods_1'] = df['value'].rolling(window=3, center=True, min_periods=1).mean()

df
"""
|   value |   rolling_mean_default |   rolling_mean_center |   rolling_mean_center_min_periods_1 |
|--------:|-----------------------:|----------------------:|------------------------------------:|
|       1 |                    nan |                   nan |                                 1.5 |
|       2 |                    nan |                     2 |                                 2   |
|       3 |                      2 |                     3 |                                 3   |
|       4 |                      3 |                     4 |                                 4   |
|       5 |                      4 |                   nan |                                 4.5 |
"""
```

## 参考
 - [pandas.DataFrame.rolling - pandas.pydata.org](https://pandas.pydata.org/docs/reference/api/pandas.DataFrame.rolling.html)
