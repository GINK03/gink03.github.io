---
layout: post
title: "exponential moving average (EMA, 指数加重移動平均)"
date: 2024-7-28
excerpt: "exponential moving average (EMA, 指数加重移動平均)の計算方法について"
project: false
kaggle: true
hide_from_post: true
tag: ["python", "pandas", "チートシート", "exponential moving average", "EMA", "指数加重移動平均"]
comments: false
sort_key: "2024-07-28"
update_dates: ["2024-07-28"]
---

# exponential moving average (EMA, 指数加重移動平均)の計算方法について

## 概要
 - 移動平均を計算する方法の一つ
 - 直近のデータに大きい重みを付け、過去のデータに対して指数関数的に減少する重みを付ける
 - 株では、EMA(12)とEMA(26)を使ってMACDを計算することがある

## 計算方法

**平滑係数（smoothing factor）**
$$
\alpha = \frac{2}{N+1}
$$

 - N: データ数

**EMAの計算式**
$$
EMA_t = \alpha \times X_t + (1 - \alpha) \times EMA_{t-1}
$$

 - t: 現在の時点
 - X_t: 現在の時点のデータ
 - EMA_(t-1): 1つ前の時点のEMA

## Pythonでの実装

```python
import pandas as pd

data = {'Date': ['1日目', '2日目', '3日目', '4日目', '5日目', '6日目', '7日目', '8日目', '9日目', '10日目', '11日目'],
        'Close': [22, 23, 21, 24, 25, 26, 28, 27, 29, 30, 31]}

df = pd.DataFrame(data)

# 10日間のEMAを計算
span = 10
df['EMA_10'] = df['Close'].ewm(span=span, adjust=False).mean()

df
"""
| Date   |   Close |   EMA_10 |
|:-------|--------:|---------:|
| 1日目  |      22 |  22      |
| 2日目  |      23 |  22.1818 |
| 3日目  |      21 |  21.9669 |
| 4日目  |      24 |  22.3366 |
| 5日目  |      25 |  22.8208 |
| 6日目  |      26 |  23.3989 |
| 7日目  |      28 |  24.2354 |
| 8日目  |      27 |  24.7381 |
| 9日目  |      29 |  25.513  |
| 10日目 |      30 |  26.3288 |
| 11日目 |      31 |  27.1781 |
"""
```
