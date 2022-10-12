---
layout: post
title: "lightgbm callbacks"
date:  2022-10-12
excerpt: "lightgbm callbacksのチートシート"
kaggle: true
project: false
tag: ["python", "lightgbm"]
comments: false
sort_key: "2022-10-12"
update_dates: ["2022-10-12"]
---


# lightgbm callbacksのチートシート

## 概要
 - 以下の機能について、callbackで関数を与える必要がある
   - early stopping
   - learning rate
   - log
 - 通常のtrain, cvなどの学習関数の引数で与えられる

## 具体例

**early stopping**
 - 最小のラウンドを設定できる

```python
early_stopping_func = lgb.early_stopping(stopping_rounds=10, first_metric_only=False)
```

**log**
 - ログの粒度
   - 1だと、1roundごとに表示
   - -1だと非表示

```python
log_evaluation_func = lgb.log_evaluation(-1)
```

**learning rate**
 - ラウンドに応じて学習率を小さくできる

```python
learning_rate_func = lgb.reset_parameter(learning_rate=lambda iter: 0.05 * (0.99 ** iter))
```

### train関数に渡す例

```python
model = lgb.train(params, 
                  train, 
                  num_boost_round=100, 
                  valid_sets=eval, 
                  callbacks=[
                              early_stopping_func, 
                              log_evaluation_func, 
                              learning_rate_func
                          ], 
                  init_model=model)
```

---

## 参考
 - [Callbacks](https://lightgbm.readthedocs.io/en/latest/Python-API.html#callbacks)
