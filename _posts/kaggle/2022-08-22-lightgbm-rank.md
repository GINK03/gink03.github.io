---
layout: post
title: "lightgbm-rank"
date: 2022-08-22
excerpt: "lightgbm rankのチートシート"
kaggle: true
tag: ["python", "lightgbm", "ランク学習"]
comments: false
sort_key: "2022-04-20"
update_dates: []
---


# lightgbm rankのチートシート

## ランク学習の具体例(1)
 - ランキング情報のラベルは上に来るものが`1`, そうでないものが`0`
   - 複数ある場合は1より大きい整数をとることができる
 - groupという`train_baskets`というユーザ単位で行数を示すデータが必要である

```python
from lightgbm.sklearn import LGBMRanker

train.sort_values(['user_id', 'date'], inplace=True)
train_baskets = train.groupby(['user_id'])['item_id'].count().values

ranker = LGBMRanker(
    objective="lambdarank",
    metric="ndcg",
    boosting_type="dart",
    max_depth=7,
    n_estimators=300,
    importance_type='gain',
    verbose=10
)
ranker = ranker.fit(
    train.drop(columns=['label']),
    train['label'],
    group=train_baskets,
)
```
 - [参考](https://www.kaggle.com/alexvishnevskiy/gbm-ranking)

---


## ランク学習の具体例(2)
 - 10個ずつクエリがあった場合に、関連度が高い物を学習する
 - 学習には疑似データを用いる

```python
import numpy as np
import pandas as pd
import lightgbm

df = pd.DataFrame({
    "query_id":[i for i in range(100) for j in range(10)],
    "var1":np.random.random(size=(1000,)),
    "var2":np.random.random(size=(1000,)),
    "var3":np.random.random(size=(1000,)),
    "relevance":list(np.random.permutation([0,0,0,0,0, 0,0,0,1,1]))*100
})
```

```python
train_df = df[:800]  # first 80%
validation_df = df[800:]  # remaining 20%

qids_train = train_df.groupby("query_id")["query_id"].count().to_numpy()
X_train = train_df.drop(["query_id", "relevance"], axis=1)
y_train = train_df["relevance"]

qids_validation = validation_df.groupby("query_id")["query_id"].count().to_numpy()
X_validation = validation_df.drop(["query_id", "relevance"], axis=1)
y_validation = validation_df["relevance"]
```

```python
model = lightgbm.LGBMRanker(
    objective="lambdarank",
    metric="ndcg",
)
```

```python
model.fit(
    X=X_train,
    y=y_train,
    group=qids_train,
    eval_set=[(X_validation, y_validation)],
    eval_group=[qids_validation],
    eval_at=10,
    verbose=10,
)
```

### Google Colab
 - [Google Colab](https://colab.research.google.com/drive/1avm_HC3I1cN_geTgHtDemVTu73HViPql?usp=sharing)

### 参考
 - [How to implement learning to rank using lightgbm?/StackOverFlow](https://stackoverflow.com/questions/64294962/how-to-implement-learning-to-rank-using-lightgbm)
