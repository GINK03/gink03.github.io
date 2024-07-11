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

## holdoutのテンプレート

```python
import lightgbm as lgb
import shap
import logging
import warnings
from sklearn.datasets import load_breast_cancer
from sklearn.model_selection import train_test_split
import pandas as pd
import matplotlib.pyplot as plt

# 警告を抑制
warnings.filterwarnings('ignore', message='No further splits with positive gain, best gain: -inf')
logging.getLogger('lightgbm').setLevel(logging.WARNING)

# データの読み込みとデータフレームの作成
data = load_breast_cancer()
df = pd.DataFrame(data.data, columns=data.feature_names)
df['target'] = data.target

# データの分割
X_train, X_valid, y_train, y_valid = train_test_split(df.drop(columns=['target']), df['target'], test_size=0.2, random_state=42)

# LightGBMのデータセットに変換
train_data = lgb.Dataset(X_train, label=y_train)
valid_data = lgb.Dataset(X_valid, label=y_valid, reference=train_data)

# パラメータ設定
params = {
    'boosting_type': 'gbdt',
    'objective': 'binary',
    'metric': ['binary_logloss', 'auc'],
    'learning_rate': 0.1,
    'num_leaves': 31,
    'verbose': -1  # ここで警告を抑制
}

# モデルのトレーニング
gbm = lgb.train(params,
                train_data,
                num_boost_round=100,
                valid_sets=[train_data, valid_data],
                valid_names=['train', 'valid'],
                callbacks=[lgb.log_evaluation(period=10)])
```

## cvのテンプレート

```python
import sys
import numpy as np
import lightgbm as lgb
from loguru import logger
from sklearn.datasets import load_breast_cancer
from sklearn.metrics import roc_auc_score, log_loss
from sklearn.model_selection import GroupKFold, train_test_split
from sklearn.preprocessing import StandardScaler
import warnings
import logging
warnings.filterwarnings('ignore', message='No further splits with positive gain, best gain: -inf')
logging.getLogger('lightgbm').setLevel(logging.WARNING)
# LightGBMの警告を無視
warnings.filterwarnings("ignore", category=UserWarning)

# ログ設定
logger.remove()
logger.add(sys.stdout, level="INFO")

# パラメータ設定
params = {
    "objective": "binary",
    "metric": ["binary_logloss", "auc"],
    "max_depth": 10,
    "num_leaves": 3,
    "learning_rate": 0.1,
    "lambda_l1": 0.0,
    "lambda_l2": 0.0,
    "is_unbalance": True,
    "bagging_seed": 777,
    "verbosity": -1,
    "seed": 777,
    "n_jobs": -1
}

# 学習率のリセット
learning_rate_func = lgb.reset_parameter(learning_rate=lambda iter: 0.25)

def cv_train(X_train, groups, y_train, category, params, eval_func, verbose_eval, early_stopping_rounds, num_boost_round):
    logger.info('Start training')
    
    train_data = lgb.Dataset(X_train, label=y_train, categorical_feature=category)

    # コールバック関数の定義
    early_stopping_func = lgb.early_stopping(stopping_rounds=early_stopping_rounds, first_metric_only=False)
    log_evaluation_func = lgb.log_evaluation(verbose_eval)
    lgb.reset_parameter()

    # Foldの定義
    group_kfold = GroupKFold(n_splits=5)

    ret = lgb.cv(
        params,
        train_data,
        folds=group_kfold.split(X_train, y_train, groups),
        num_boost_round=num_boost_round,
        #verbose_eval=verbose_eval,
        callbacks=[early_stopping_func, log_evaluation_func, learning_rate_func],
        return_cvbooster=True
    )

    cvclf = ret["cvbooster"]
    preds = np.vstack([clf.predict(X_train) for clf in cvclf.boosters]).mean(axis=0)
    eval_loss = log_loss(y_train, preds)
    logger.info(f'End of training. Eval loss={eval_loss}')

    return {'eval_loss': eval_loss, 'models': cvclf.boosters}

# サンプルデータの読み込み
data = load_breast_cancer()
X, y = data.data, data.target
groups = np.random.randint(0, 5, size=X.shape[0])

# データの標準化
scaler = StandardScaler()
X = scaler.fit_transform(X)

# 訓練データとテストデータの分割
X_train, X_test, y_train, y_test, groups_train, groups_test = train_test_split(X, y, groups, test_size=0.2, random_state=777)

# モデルの訓練
result = cv_train(X_train, groups_train, y_train, None, params, roc_auc_score, 50, 100, 1000)

# テストデータでの評価
models = result['models']
preds = np.vstack([model.predict(X_test) for model in models]).mean(axis=0)
test_loss = log_loss(y_test, preds)
test_auc = roc_auc_score(y_test, preds)
logger.info(f'Test Log Loss: {test_loss}')
logger.info(f'Test AUC: {test_auc}')
```
