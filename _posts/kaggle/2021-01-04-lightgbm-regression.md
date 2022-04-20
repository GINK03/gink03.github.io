---
layout: post
title: "lightgbm regression"
date: 2021-01-04
excerpt: "lightgbm regressionのチートシート"
kaggle: true
project: false
config: true
tag: ["python", "lightgbm", "regression"]
comments: false
---


# lightgbm regressionのチートシート

## 概要
 - クラス推定に比べてcvの引数を考慮したり、大きい数字を推論する際には対数で予測させたほうが都合が良いなど、さまざまな回帰用のノウハウが有る

## cvのテンプレート

```python
import sys
from loguru import logger
logger.remove(); logger.add(sys.stdout, level="INFO")

import lightgbm as lgb
from sklearn.metrics import mean_squared_error
from sklearn.metrics import mean_absolute_error
import numpy as np

param = {
    "objective": "regression_l1",
    "metric": "mae",
    "max_depth": 5,
    "num_leaves": 5,
    "learning_rate": 0.1,
    # "bagging_fraction": 0.0,
    # "feature_fraction": 0.0,
    "lambda_l1": 0.,
    "lambda_l2": 0.,
    "is_unbalance": True, # binary時の非対称時データの場合
    "bagging_seed": 777,
    "verbosity": -1,
    "seed": 777,
    # 'max_bin': 512,
    "n_jobs": -1 # 並列数
}
def cv_train(X_train, y_train, category, param, eval_func, verbose, early_stopping_rounds, n_estimators):
    logger.info(f'now start to train')
    trn_data = lgb.Dataset(X_train, label=y_train, categorical_feature=category)
    num_round = n_estimators
    lgb.reset_parameter()
    ret = lgb.cv(
            params=param,
            train_set=trn_data,
            nfold=5, # fold数, 多いと安定する
            num_boost_round=num_round,
            verbose_eval=verbose,
            early_stopping_rounds=early_stopping_rounds,
            return_cvbooster=True, # 作成したモデルを戻す
            stratified=False) # 回帰なのでstratifiedはFalseに設定
    cvclf = ret["cvbooster"]
    preds = np.vstack([clf.predict(X_train) for clf in cvclf.boosters]).mean(axis=0)
    eval_loss = eval_func(np.expm1(y_train), np.expm1(preds))
    # eval_loss = eval_func(y_train, preds)
    logger.info(f'end eval_loss={eval_loss}')

    return {'eval_loss': eval_loss,
            'models': cvclf.boosters} # 推論時は平均する必要がある

df = df.sample(frac=1)
X_train = df.drop(columns=["target"]).copy()
y_train = np.log1p(df["target"])
category = []
param = param
eval_func = mean_absolute_error
verbose = 10
early_stopping_rounds = 10
n_estimators = 1000
ret = cv_train(X_train, y_train, category, param, eval_func, verbose, early_stopping_rounds, n_estimators)
display(ret["eval_loss"])
```

---

## トラブルシューティング
 - cvでエラーが出る
   - 原因
     - 回帰なのでデフォルトのstratifiedが内部的に有効になっている
   - 対応
     - 明示的にstratifiedを無効にする

---

## 参考
 - [LightGBMのパラメータ](https://lightgbm.readthedocs.io/en/latest/Parameters.html)
