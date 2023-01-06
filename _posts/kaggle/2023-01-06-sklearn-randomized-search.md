---
layout: post
title: "sklearn randomized search"
date: 2023-01-06
excerpt: "sklearn randomized searcheの使い方"
tags: ["python3", "sklearn", "randomized search"]
kaggle: true
comments: false
sort_key: "2023-01-06"
update_dates: ["2023-01-06"]
---

# sklearn randomized searchの使い方

## 概要
 - ランダムにパラメータを選択して最もロスが少ないものを選ぶ
 - 連続変数を分布を指定して入力することができる
 - 整数を指定することができる
 - カテゴリを指定することができる

## irisの学習の例

```python
from sklearn.datasets import load_iris
from sklearn.linear_model import LogisticRegression
from sklearn.model_selection import RandomizedSearchCV
from scipy.stats import uniform, randint
from sklearn.model_selection import RandomizedSearchCV, TimeSeriesSplit, KFold

iris = load_iris()
logistic = LogisticRegression(solver='saga', 
                              tol=1e-2, 
                              max_iter=200,
                              random_state=0)
clf = RandomizedSearchCV(
        estimator=logistic, 
        param_distributions=dict( # 調べたいパラメータの分布
            C=uniform(loc=0, scale=4), 
            penalty=['l2', 'l1'],
            # any=randint(1, 20), # 整数で与える例
        ), 
        cv=KFold(n_splits=5, shuffle=True), # 任意のfold
        random_state=0,
        n_iter=500, # 試行回数
        n_jobs=-1,
    )
search = clf.fit(iris.data, iris.target)
display(search.best_params_)
display(search.cv_results_['params'][search.best_index_]) # best scoreのパラメータ

# randomized search cvの結果はpredictできる
search.predict(iris.data)
```

### Google Colab
 - [randomized-search-cv](https://colab.research.google.com/drive/13feI1uYjTmuT2RpU-MI5VLCQ2XuejeCW?usp=sharing)
