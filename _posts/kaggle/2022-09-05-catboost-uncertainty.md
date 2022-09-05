---
layout: post
title: "catboost uncertainty"
date: 2022-09-05
excerpt: "catboost uncertaintyの仕組みとチートシート"
kaggle: true
tag: ["python", "catboost", "uncertainty", "不確実性", "分散"]
comments: false
sort_key: "2022-09-05"
update_dates: ["2022-09-05"]
---

# catboost uncertaintyの仕組みとチートシート

## 概要
 - catboostは決定木でありながら、不確実性を計算することができる
 - 技術的には`Virtual ensemble`とうことをやっている
   - 一つのモデルの内部で決定木の乱択をやっているようである
 - 回帰でも使用でき、`RMSEWithUncertainty`という損失関数になっている

## RMSEWithUncertaintyのスニペット

```python
model = CatBoostRegressor(iterations=1000, learning_rate=0.2, loss_function='RMSEWithUncertainty',
                          verbose=False, random_seed=0)

model.fit(train_pool, eval_set=val_pool)
print("best iteration =", model.get_best_iteration())
preds = model.predict(test)

mean_preds = preds[:, 0] #the first prediction is the estimated mean value
var_preds = preds[:, 1] #the second prediction is the estimated variance
```

### Google Colab
 - [catboost-uncertainty-example](https://colab.research.google.com/drive/1_HKHoGaTRm-0Z2VJhv52gNumQ2T4nTGm?usp=sharing)

---

## 参考
 - [Tutorial: Uncertainty estimation with CatBoost](https://towardsdatascience.com/tutorial-uncertainty-estimation-with-catboost-255805ff217e)
