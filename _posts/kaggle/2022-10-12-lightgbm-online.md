---
layout: post
title: "lightgbm online"
date:  2022-10-12
excerpt: "lightgbm online(オンライン学習)のチートシート"
kaggle: true
project: false
tag: ["python", "lightgbm", "オンライン学習"]
comments: false
sort_key: "2022-10-12"
update_dates: ["2022-10-12"]
---


# lightgbm online(オンライン学習)のチートシート

## 概要
 - アップデートされた情報に対して、モデルの初期値を用意して学習することができる
 - 一種のオンライン学習のようなことができる
   - モデルの複雑度は増す方向にしか行かないので使用には注意
 - データ量が非常に大きいときにも用いることができる

## 具体例

```python
model = lgb.train(params, 
                  train, 
                  num_boost_round=100, 
                  valid_sets=eval, 
                  callbacks=[early_stopping_func, log_evaluation_func, learning_rate_func], 
                  init_model=model # 前のモデルを引数に与える
            )
```

## ヒューリスティック
 - 精度的な側面
   - メモリに乗るのであれば全体をcvで学習したほうが良さそう
 - 特徴量重要度の分布が重要度ではなくなっていく
   - コーナーケースを学習していくからか
