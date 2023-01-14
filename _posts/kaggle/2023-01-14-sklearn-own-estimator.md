---
layout: post
title: "sklearn own estimator"
date: 2023-01-14
excerpt: "sklearn own estimatorの設計と開発"
tags: ["python3", "sklearn", "pipeline", "estimator"]
kaggle: true
comments: false
sort_key: "2023-01-12"
update_dates: ["2023-01-12"]
---

# sklearn own estimatorの設計と開発

## 概要
 - `sklearn`形式の`fit`, `predict`, `transform`などを一般化したインターフェースで扱う方法
 - `sklearn`のパイプラインで設計された処理に独自のestimatorを組み込む際に、独自に設計・開発が必要
 - 様々なtemplateが[github](https://github.com/scikit-learn-contrib/project-template/blob/master/skltemplate/_template.py)に用意されている

## 具体例
 - 独自のclassifierを実装する例
 - regressorの場合には継承する元を変える

```python
import numpy as np
from sklearn.base import BaseEstimator, ClassifierMixin
from sklearn.utils.validation import check_X_y, check_array, check_is_fitted
from sklearn.utils.multiclass import unique_labels
from sklearn.metrics import euclidean_distances
class TemplateClassifier(BaseEstimator, ClassifierMixin):

    def __init__(self, demo_param='demo'):
        self.demo_param = demo_param

    def fit(self, X, y):

        # Check that X and y have correct shape
        X, y = check_X_y(X, y)
        # Store the classes seen during fit
        self.classes_ = unique_labels(y)

        self.X_ = X
        self.y_ = y
        # Return the classifier
        return self

    def predict(self, X):

        # Check if fit has been called
        check_is_fitted(self)

        # Input validation
        X = check_array(X)

        closest = np.argmin(euclidean_distances(X, self.X_), axis=1)
        return self.y_[closest]
```

---

## 参考
 - [Rolling your own estimator/scikit-learn.org](https://scikit-learn.org/stable/developers/develop.html#rolling-your-own-estimator)
