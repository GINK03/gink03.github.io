---
layout: post
title: "sklearn pipeline"
date: 2023-01-06
excerpt: "sklearn pipelineの使い方"
tags: ["python3", "sklearn", "pipeline"]
kaggle: true
comments: false
sort_key: "2023-01-06"
update_dates: ["2023-01-06"]
---

# sklearn pipelineの使い方

## 概要
 - sklearnでデータの変換・学習をパイプラインで行えるようにするためのライブラリ

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

## 特徴量生成して学習する例

```python
import numpy as np

from sklearn.compose import ColumnTransformer
from sklearn.datasets import fetch_openml
from sklearn.pipeline import Pipeline
from sklearn.impute import SimpleImputer
from sklearn.preprocessing import StandardScaler, OneHotEncoder
from sklearn.linear_model import LogisticRegression
from sklearn.model_selection import train_test_split, GridSearchCV

np.random.seed(0)

X, y = fetch_openml(
    "titanic", version=1, as_frame=True, return_X_y=True
)

preprocessor = ColumnTransformer(
    transformers=[
        ("num", 
            Pipeline(steps=[("imputer", SimpleImputer(strategy="median")), ("scaler", StandardScaler())]), 
            ["age", "fare"]
         ),
        ("cat", 
            OneHotEncoder(handle_unknown="ignore"), 
            ["embarked", "sex", "pclass"]
         ),
    ]
)

clf = Pipeline(
    steps=[("preprocessor", preprocessor), ("classifier", LogisticRegression())]
)

X_train, X_test, y_train, y_test = train_test_split(X, y, test_size=0.2, random_state=0)

clf.fit(X_train, y_train)
print("model score: %.3f" % clf.score(X_test, y_test)) # model score: 0.790
```

---

## 参考
 - [sklearn.compose.ColumnTransformer/scikit-learn.org](https://scikit-learn.org/stable/modules/generated/sklearn.compose.ColumnTransformer.html)
