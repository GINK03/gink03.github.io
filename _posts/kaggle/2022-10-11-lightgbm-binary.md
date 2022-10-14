---
layout: post
title: "lightgbm binary"
date: 2022-10-11
excerpt: "lightgbm binaryのチートシート"
kaggle: true
project: false
tag: ["python", "lightgbm"]
comments: false
sort_key: "2022-10-11"
update_dates: ["2022-10-11"]
---

## cvのテンプレート

```python
import lightgbm as lgb
import sys
from loguru import logger
from sklearn.metrics import roc_auc_score
import numpy as np
logger.remove()
logger.add(sys.stdout, level="INFO")

param = {
    "objective": "binary",
    "metric": "auc", # "binary_logloss"
    "max_depth": 5,
    "num_leaves": 5,
    "learning_rate": 0.1,
    # "bagging_fraction": 0.0,
    # "feature_fraction": 0.0,
    "lambda_l1": 0.0,
    "lambda_l2": 0.0,
    "is_unbalance": True, # binary時の非対称時データの場合
    "bagging_seed": 777,
    "verbosity": -1,
    "seed": 777,
    # 'max_bin': 512,
    "n_jobs": -1 # 並列数
}

learning_rate_func = lgb.reset_parameter(learning_rate=lambda iter: 0.25)
from loguru import logger
from sklearn.metrics import log_loss
from sklearn.model_selection import GroupKFold
def cv_train(X_train, groups, y_train, category, params, eval_func, verbose_eval, early_stopping_rounds, num_boost_round):
    logger.info(f'now start to train')
    train_data = lgb.Dataset(X_train, label=y_train, categorical_feature=category)
    # callback関数を定義
    early_stopping_func = lgb.early_stopping(stopping_rounds=early_stopping_rounds, first_metric_only=False)
    log_evaluation_func = lgb.log_evaluation(verbose_eval)
    lgb.reset_parameter()
    
    # foldを定義
    group_kfold = GroupKFold(n_splits=5)
    
    ret = lgb.cv(
            params,
            train_data,
            folds=group_kfold.split(X_train, y_train, groups),
            # nfold=4, # fold数
            num_boost_round=num_boost_round,
            verbose_eval=verbose_eval,
            callbacks=[early_stopping_func, log_evaluation_func, learning_rate_func],
            return_cvbooster=True) # 作成したモデルを戻す
    # logger.info(f"{ret}")
    cvclf = ret["cvbooster"]
    preds = np.vstack([clf.predict(X_train) for clf in cvclf.boosters]).mean(axis=0)
    eval_loss = log_loss(y_train, preds)
    logger.info(f'end eval_loss={eval_loss}')

    return {'eval_loss': eval_loss,
            'models': cvclf.boosters} # 推論時は平均する必要がある
```
