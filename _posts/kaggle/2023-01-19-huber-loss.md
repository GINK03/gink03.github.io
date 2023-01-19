---
layout: post
title: "huber loss"
date: 2023-01-19
excerpt: "huber lossについて"
tags: ["python3", "sklearn", "huber loss", "huber regression"]
kaggle: true
comments: false
sort_key: "2023-01-12"
update_dates: ["2023-01-12"]
---

# huber lossについて

## 概要
 - MSEで回帰すると外れ値にだいぶ影響されてしまう問題を解決するため、ある一定数以下まではMSEで、それ以上ではMAEの損失を用いる
   - 外れ値ロバストになる
 - `sklearn`に`sklearn.linear_model.HuberRegressor`が存在する

## 定義

$$
{\displaystyle L_{\delta }(a)={\begin{cases}{\frac {1}{2}}{a^{2}}&{\text{for }}|a|\leq \delta ,\\\delta \cdot \left(|a|-{\frac {1}{2}}\delta \right),&{\text{otherwise.}}\end{cases}}}
$$

---

## 参考
 - [Regression in the face of messy outliers? Try Huber regressor](https://towardsdatascience.com/regression-in-the-face-of-messy-outliers-try-huber-regressor-3a54ddc12516)
 - [Huber loss/Wikipedia](https://en.wikipedia.org/wiki/Huber_loss)
