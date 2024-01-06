---
layout: post
title: "tensorflow decision forests"
date: 2024-01-06
excerpt: "tensorflow decision forestsの使い方"
kaggle: true
hide_from_post: true
tag: ["tensorflow", "decision-forests", "kaggle", "tfdf"]
comments: false
sort_key: "2024-01-06"
update_dates: ["2024-01-06"]
---

# tensorflow decision forestsの使い方

## 概要
 - tensorflowのエコシステムを利用した決定木の実装
 - 商用利用可能
 - Keras APIと同じように使える

## インストール

```console
$ pip install tensorflow_decision_forests
```

## 使用例

```python
import tensorflow as tf
import tensorflow_decision_forests as tfdf
import pandas as pd
import numpy as np
import seaborn as sns
import matplotlib.pyplot as plt
from IPython.display import HTML

# titanicデータセットをロード
titanic = sns.load_dataset('titanic')
titanic

# 使用できるモデルの一覧を表示
tfdf.keras.get_all_models()

# モデルの作成
model = tfdf.keras.RandomForestModel()
model.compile(metrics=["accuracy"])

# 特徴量の選択
titanic = titanic[["survived", "pclass", "age", "sex"]]

# データセットの分割
train_ds = tfdf.keras.pd_dataframe_to_tf_dataset(titanic.head(700), label="survived")
valid_ds = tfdf.keras.pd_dataframe_to_tf_dataset(titanic.tail(100), label="survived")

# モデルの学習
model.fit(x=train_ds)

# モデルの評価
evaluation = model.evaluate(x=valid_ds,return_dict=True)
for name, value in evaluation.items():
  print(f"{name}: {value:.4f}")

# 決定木の数と精度の関係
logs = rf.make_inspector().training_logs()
plt.plot([log.num_trees for log in logs], [log.evaluation.accuracy for log in logs])
plt.xlabel("Number of trees")
plt.ylabel("Accuracy (out-of-bag)")
plt.show()
```

### Google Colab
 - [tfdf-example.ipynb](https://colab.research.google.com/drive/1qXoC--pybiMT4vmaiMZ1w_vrDKOV_hSq?usp=sharing)
