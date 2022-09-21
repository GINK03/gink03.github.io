---
layout: post
title: "scipy-optimize"
date: 2022-05-08
excerpt: "scipy-optimizeの使い方"
project: false
kaggle: true
tag: ["最適化", "optimize", "scipy"]
comments: false
sort_key: "2022-05-08"
update_dates: ["2022-05-08"]
---

# scipy-optimizeについて

## 概要
 - メジャーな最適化アルゴリズムを抑えた使いやすい最適化フレームワーク
   - デフォルトでは`BFGS`, `L-BFGS-B`, `SLSQP`を使う
   - `Nelder-Mead`などの微分を使わない方法もサポート
 - 制約条件の有無
   - 一致の制約条件、boolの制約条件などを入れられる


## 具体例(10つの状態を取りうるときにエントロピーが最大になるそれぞれの確率)
 - エントロピーが最大=何もわからなく、差がない状態=すべてが同じ確率になるはずである

```python
import numpy as np
import random
from scipy import optimize
# 初期値は適当
x = np.array([random.random() for i in range(10)])
x /= x.sum()
print(x)
"""
array([0.17568076, 0.08893014, 0.08130814, 0.13588037, 0.04452422,
       0.10659483, 0.11712342, 0.1996713 , 0.04659363, 0.00369318])
"""

def func(x):
    return -(-(x@np.log(x)).sum()) # 最大化したいので-を掛ける

def constraint(x):
    return x.sum() - 1

cons = [{'type':'eq', 'fun': constraint},]

ret = optimize.minimize(func, x0=x, constraints=cons)
print(ret.x) 
"""
array([0.09999446, 0.10001536, 0.10002089, 0.09996406, 0.10000083,
       0.09999554, 0.09997974, 0.10000217, 0.09999922, 0.10002772])
"""
```
 - 初期の想定通りにすべてがおおよお同じ値になった

### Google Colab
 - [scipy-optimize-example](https://colab.research.google.com/drive/1Ht_PjSa5KdEYMwYiM26MQA8yJRzxxf29?usp=sharing)

---

## 具体例(最適化の範囲を限定して回帰で近似)

```python
# 説明変数と目的変数を分ける
X = m.drop(columns=["target"]).copy()
y = m["target"]

# 説明変数と目的変数を標準化
for col in X.columns:
    X[col] = (X[col] - np.mean(X[col]))/np.std(X[col])
X_values = X.values
y_values = (y - np.mean(y))/np.std(y)

# 最小化関数を定義
def func(x):
    tmp = np.zeros(len(X_values))
    for i in range(len(x)):
        tmp += x[i] * X_values[:, i]
    return (y_values  - tmp).abs().sum()

# 探索範囲を準備
bounds = [(0, np.inf) for _ in range(len(X.columns)) ]

# 最適化
x = np.zeros(len(X.columns)) + 1/300
ret = optimize.minimize(func, x0=x, bounds=bounds, options={'eps': 1e-8, "max_iter": 2500} ) 

# 結果を表示
rf = pd.DataFrame(list(zip(X.columns, ret.x)))
rf.columns = ["feat", "exp"]
display(rf.sort_values(by=["exp"], ascending=False).style.hide_index())
```

---

## 参考
 - [scipy.optimize.minimize](https://docs.scipy.org/doc/scipy/reference/generated/scipy.optimize.minimize.html)

