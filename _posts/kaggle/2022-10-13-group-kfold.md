---
layout: post
title: "group kfold"
date: 2022-10-13
excerpt: "group kfoldの使い方"
kaggle: true
tag: ["fold", "groupkfold"]
comments: false
sort_key: "2022-10-13"
update_dates: ["2022-10-13"]
---

# group kfoldの使い方

## 概要
 - 特定のキーを与えて、そのキーに基づき、foldを切る際に便利
   - 時系列で複数の試合のデータなどがあるときなど
     - ランダムにsplitするとリークする
 - グループを示すキーを指定する必要がある

## 具体例

```python
# 5個のグループに分割したい場合
groups = train["match_id"].apply(lambda x:x%5)
group_kfold = GroupKFold(n_splits=5)

for train_idx, test_index in group_kfold.split(df[train_features], df[label], groups):
    pass
```

---

## 参考
 - [sklearn.model_selection.GroupKFold](https://scikit-learn.org/stable/modules/generated/sklearn.model_selection.GroupKFold.html)
