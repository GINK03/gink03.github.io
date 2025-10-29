---
layout: post
title: "NumPy where"
date: 2025-10-29
excerpt: "NumPy の where 関数の使い方について解説"
project: false
kaggle: true
tag: ["numpy", "python"]
comments: false
sort_key: "2025-10-29"
update_dates: ["2025-10-29"]
---

# NumPy の `where` 関数の使い方

## 概要
 - 基本構文
   - `np.where(条件, 条件が True のときの値, 条件が False のときの値)`

## 具体例

```python
import pandas as pd
import numpy as np

# データフレームの作成
df = pd.DataFrame({
    '名前': ['田中', '佐藤', '鈴木', '高橋', '伊藤'],
    '点数': [85, 55, 72, 45, 90]
})

# 60点以上を合格、未満を不合格とする
df['判定'] = np.where(df['点数'] >= 60, '合格', '不合格')
display(df)
"""
| 名前   |   点数 | 判定   |
|:-------|-------:|:-------|
| 田中   |     85 | 合格   |
| 佐藤   |     55 | 不合格 |
| 鈴木   |     72 | 合格   |
| 高橋   |     45 | 不合格 |
| 伊藤   |     90 | 合格   |
"""
```

## 複数条件（SQL IF 風）

SQL の IF のように、条件を段階的に評価して分類したい場合は入れ子の `np.where` を使用

```python
df['評価'] = np.where(
    df['点数'] >= 80, 'A',
    np.where(
        df['点数'] >= 60, 'B',
        np.where(df['点数'] >= 40, 'C', 'D')
    )
)

display(df)
"""
| 名前   |   点数 | 評価   |
|:-------|-------:|:-------|
| 田中   |     85 | A      |
| 佐藤   |     55 | C      |
| 鈴木   |     72 | B      |
| 高橋   |     45 | C      |
| 伊藤   |     90 | A      |
"""
```
