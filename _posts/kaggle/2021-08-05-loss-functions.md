---
layout: post
title: "loss functions"
date: 2021-08-05
excerpt: "損失関数各種"
kaggle: true
hide_from_post: true
tag: ["sklearn", "python", "loss function", "損失関数"]
comments: false
sort_key: "2021-08-06"
update_dates: ["2021-08-06"]
---

# 損失関数各種

## l1
 - 絶対値

## l2
 - 二乗

## RMSPE
メトリックが以下で示されるとき

$$
\sqrt { \frac{1}{n} \sum_{i=1} (({y_i - \hat{y_i})/y_i})^2}
$$

RMSEに以下のウェイトをかければよい

$$
\frac{1}{y_i}
$$

 - [参考](https://www.kaggle.com/c/optiver-realized-volatility-prediction/discussion/250324)
