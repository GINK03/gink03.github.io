---
layout: post
title: "feature combining"
date: 2021-01-30
excerpt: "feature combiningとその方法"
featuer: true
hide_from_post: true
tag: ["feature", "feature combining", "python"]
comments: false
---

# feature combiningとその方法
 - 特定の特徴量の組み合わせて特徴量を表現する手法
 - 組み合わせ
   - 足し算
   - 引き算
   - 掛け算
   - 割り算

### ライブラリ`featuretools`の例

`Deep Feature Synthesis`、略して`dfs`と呼ばれる

例えば、irisのデータセットを読み込み
```python
from sklearn.datasets import load_iris
import pandas as pd
import featuretools as ft

# Load data and put into dataframe
iris = load_iris()
df = pd.DataFrame(iris.data, columns = iris.feature_names)
df['species'] = iris.target
df['species'] = df['species'].map({0: 'setosa', 1: 'versicolor', 2: 'virginica'})
```

`add_numeric`, `multiply_numeric`を適応する
```python
# Make an entityset and add the entity
es = ft.EntitySet(id = 'id')
es.entity_from_dataframe(
                        entity_id = 'data', 
                        dataframe = df, 
                        make_index = True, 
                        index = 'index')
# Run deep feature synthesis with transformation primitives
feature_matrix, feature_defs = ft.dfs(entityset = es, target_entity = 'data',
                                      trans_primitives = ['add_numeric', 'multiply_numeric'])

feature_matrix.head()
```

#### 使用できる`primitives`

以下のコマンドで確認できる
```python
import featuretools as ft
ft.list_primitives()
```
 - percent_true
 - last
 - num_true
 - std
 - num_unique
 - sum
 - skew
 - mode
 - time_since_first
 - max
 - median
 - mean
 - time_since_last
