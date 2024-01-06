---
layout: post
title: "seaborn dataset"
date: 2024-01-06
excerpt: "seaborn datasetの使い方"
kaggle: true
hide_from_post: true
tag: ["seaborn", "dataset", "python"]
comments: false
sort_key: "2024-01-06"
update_dates: ["2024-01-06"]
---

# seaborn datasetの使い方

## 概要
 - seabornには簡単に使えるデータセットが用意されている
 - toy datasetとして使える

## 使用

**データセットの一覧を表示**
```python
import seaborn as sns
sns.get_dataset_names()
"""
['anagrams',
 'anscombe',
 'attention',
 'brain_networks',
 'car_crashes',
 'diamonds',
 'dots',
 'dowjones',
 'exercise',
 'flights',
 'fmri',
 'geyser',
 'glue',
 'healthexp',
 'iris',
 'mpg',
 'penguins',
 'planets',
 'seaice',
 'taxis',
 'tips',
 'titanic']
"""
```

**データセットの読み込み**
```python
import seaborn as sns
titanic = sns.load_dataset("titanic")
```

## 参考
 - [seaborn-data](https://github.com/mwaskom/seaborn-data)
