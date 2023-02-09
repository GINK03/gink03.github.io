---
layout: post
title: "scipy stats"
date: 2023-02-09
excerpt: "scipy statsの使い方"
kaggle: true
tag: ["python", "scipy", "stats", "チートシート"]
comments: false
sort_key: "2023-02-09"
update_dates: ["2023-02-09"]
---

# scipy statsの使い方

## 概要
 - 様々な分布(正規分布など)の確率密度関数などから確率を計算したりできる

## 具体例

### 正規分布で平均値・標準偏差が既知のとき観測データの確率を確率密度関数から得る

```python
from scipy.stats import norm

prob = norm(<observed_x>, loc=<mean>, scale=<std>)
```

---

## 参考
 - [scipy.stats.norm/docs.scipy.org](https://docs.scipy.org/doc/scipy/reference/generated/scipy.stats.norm.html)
