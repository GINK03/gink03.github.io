---
layout: post
title: "sklearn elasticnet"
date: 2024-11-12
excerpt: "sklearn elasticnetの使い方"
tags: ["python3", "sklearn", "elasticnet"]
kaggle: true
comments: false
sort_key: "2024-11-12"
update_dates: ["2024-11-12"]
---

# sklearn elasticnetの使い方

## 概要
 - `ElasticNet` を用いる方法と `SGDRegressor` を用いる方法がある
   - `ElasticNet` - 座標降下法を用いる
   - `SGDRegressor` - 確率的勾配降下法を用い、スパースや大規模データに向いている

## パラメータの意味
 - `alpha` - L1,L2の正則化項の強度
 - `l1_ratio` - L1正則化の割合
   - `0.0`: L2正則化
   - `1.0`: L1正則化

## サンプルコード

```python
from sklearn.linear_model import ElasticNet
from sklearn.linear_model import SGDRegressor

from sklearn.model_selection import train_test_split
from sklearn.metrics import mean_squared_error, mean_absolute_error, r2_score
import numpy as np

# データの分割
X_train, X_test, y_train, y_test = train_test_split(X, y, test_size=0.2, random_state=42)

# ElasticNet の初期化
# model = ElasticNet(alpha=1.0, l1_ratio=0.0, random_state=42)
model = SGDRegressor(
    penalty='elasticnet',
    alpha=1e-5,
    l1_ratio=0.0,
    max_iter=10000,
    tol=1e-3,
    random_state=42,
)

# 学習
model.fit(X_train, y_train)

# 予測
y_pred = model.predict(X_test)

# 評価指標
mse = mean_squared_error(y_test, y_pred)
mae = mean_absolute_error(np.expm1(y_test), np.expm1(y_pred))
r2 = r2_score(y_test, y_pred)

print(f"Mean Squared Error (MSE): {mse:.4f}")
print(f"R^2 Score: {r2:.4f}")
print(f"Mean Absolute Error (MAE): {mae:.4f}")
```
