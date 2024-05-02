---
layout: post
title: "numpy random choice"
date: 2024-05-02
excerpt: "numpy random choiceの使い方"
project: false
kaggle: true
tag: ["numpy", "python"]
comments: false
sort_key: "2024-05-02"
update_dates: ["2024-05-02"]
---

# numpy random choiceの使い方

## 概要
 - `np.random.choice`は、配列からランダムに要素を選択する関数
 - seedを固定して再現性を持たせることができる
   - `np.random.seed(42)`

## パラメータ
 - `a` : 配列
 - `size` : 選択する要素数
 - `replace` : 復元抽出 or 非復元抽出
 - `p` : 選択確率

## サンプルコード

**復元抽出**
```python
import numpy as np

# seedの固定
np.random.seed(42)
data = np.array([1, 2, 3, 4, 5])
sample_with_replacement = np.random.choice(data, size=3, replace=True)
```

**非復元抽出**
```python
sample_without_replacement = np.random.choice(data, size=3, replace=False)
```

**選択確率を指定**
```python
weights = [0.1, 0.1, 0.2, 0.3, 0.3]
sample_with_weights = np.random.choice(data, size=3, replace=True, p=weights)
```
