---
layout: post
title: "sklearn column transformer"
date: 2023-01-12
excerpt: "sklearn column trasnformerの使い方と定義"
tags: ["python3", "sklearn", "pipeline", "column trasnformer"]
kaggle: true
comments: false
sort_key: "2023-01-12"
update_dates: ["2023-01-12"]
---

# sklearn column trasnformerの使い方と定義

## 概要
 - pandasのデータフレームをカラム名を指定して加工するsklearnのpipeline
 - 自分で`ColumnTransformer`を定義するには`BaseEstimator, TransformerMixin`を継承する
   - `fit`と`transform`の動作を定義する
 - 最新のsklearnではpandasのdataframeeを返すことも可能

## ColumnTransformerでpandasのデータの変換する例
 - `ColumnTransformer`の引数に`(処理の名前, 処理の関数, カラム名)`のリストで与える
 - 変換した結果を得るには`fit_transform`関数を使用する

```python
# ref. https://scikit-learn.org/stable/modules/generated/sklearn.compose.ColumnTransformer.html
import pandas as pd
from sklearn.feature_extraction import FeatureHasher
from sklearn.preprocessing import MinMaxScaler

X = pd.DataFrame({
    "documents": ["First item", "second one here", "Is this the last?"],
    "width": [3, 4, 5],
})  
ct = ColumnTransformer(
        transformers=[
            # feature hashingする
            # ("text_preprocess", FeatureHasher(input_type="string"), "documents"),
            # minmaxでスケーリングする
            ("num_preprocess", MinMaxScaler(), ["width"])
        ]
    )
X_trans = ct.fit_transform(X)
X_trans
```

## 自分で`ColumnTransformer`を定義する例
 - 例ではファイルに分割していないが、実用上はファイル・モジュールに分割して利用する

```python
from __future__ import annotations
# from abc import ABC, abstractmethod
from typing import List, Optional
import numpy as np
from sklearn.base import BaseEstimator, TransformerMixin
from sklearn.utils.validation import (
    FLOAT_DTYPES,
    _check_feature_names_in,
    check_array,
    check_is_fitted,
)

class TransformerEx(BaseEstimator, TransformerMixin):
    def __init__(self, exponent: float = 1.0, denominator_shift: float = 1.0) -> None:
        """Initialize."""
        self.exponent = exponent
        self.denominator_shift = denominator_shift

    def fit(self, X: np.ndarray, y: None = None) -> TransformerEx:
        """
        Fit the transformer.
        In this special case, nothing is done.
        Parameters
        ----------
        X : Ignored
            Not used, present here for API consistency by convention.
        y : Ignored
            Not used, present here for API consistency by convention.
        Returns
        -------
        Saturation
            Fitted transformer.
        """
        _ = self._validate_data(X, dtype=FLOAT_DTYPES)
        return self

    def transform(self, X: np.ndarray) -> np.ndarray:
        """
        Apply the saturation effect.
        Parameters
        ----------
        X : np.ndarray
            Data to be transformed.
        Returns
        -------
        np.ndarray
            Data with saturation effect applied.
        """
        check_is_fitted(self)
        X = check_array(X)
        self._check_n_features(X, reset=False)

        # return self._transformation(X)
        return X * 2

    def get_feature_names_out(self, input_features: Optional[List] = None):
        """
        Get the output feature names.
        Parameters
        ----------
        input_features : list (optional), default0None
            Input feature names.
        Returns
        -------
        np.ndarray
            Output feature names.
        """
        input_features = _check_feature_names_in(self, input_features)
        return np.array(input_features, dtype=object)

import numpy as np
import pandas as pd
from sklearn.compose import ColumnTransformer
from sklearn.pipeline import Pipeline
if __name__ == "__main__":
    df = pd.DataFrame()
    df["number"] = list(range(10))
    print(df)
    ct = ColumnTransformer(
        transformers=[
            ("num",
                Pipeline(steps=[("run transformer_ex", TransformerEx())]),
                ["number"]
             ),
        ]
    )
    # ct.set_output('pandas')
    # 単純に二倍する例
    r: np.ndarray = ct.fit_transform(df)
    print(r)
```

---

## 参考
 - [Garve/mamimo/github.com](https://github.com/Garve/mamimo/blob/main/mamimo/saturation.py)
