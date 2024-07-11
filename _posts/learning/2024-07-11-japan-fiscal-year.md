---
layout: post
title: "japan fiscal year"
date: 2024-07-11
excerpt: "japan fiscal year(日本の会計年度)について"
project: false
learning: true
tag: ["日本の会計年度", "fiscal year", "pandas", "python", "Google Play Store"]
comments: false
---

# japan fiscal year(日本の会計年度)について

## 会計年度
 - 4月1日から翌年3月31日までの期間

## 時間データのfiscal yearへの変換方法

```python
import pandas as pd

# サンプルのGoogle Play Storeデータセットを読み込み
url = "https://raw.githubusercontent.com/enjoykcc456/google-playstore-analysis/main/googleplaystore.csv"
df = pd.read_csv(url)

df['Last Updated'] = pd.to_datetime(df['Last Updated'], errors='coerce')

# 日本の年度を計算する関数を定義
def get_japan_fiscal_year(date):
    if pd.isnull(date):
        return None
    year = date.year
    if date.month < 4:
        return year - 1
    else:
        return year

# 日本の年度列を追加
df['japan_fiscal_year'] = df['Last Updated'].apply(get_japan_fiscal_year)

# 結果を表示
display(df[['App', 'Last Updated', 'japan_fiscal_year']])
```
