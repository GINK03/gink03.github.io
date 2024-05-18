---
layout: post
title: "ydata-profiling"
date: 2024-05-18
excerpt: "ydata-profilingの使い方"
project: false
kaggle: true
tag: ["python", "eda", "ydata-profiling"]
comments: false
sort_key: "2024-05-18"
update_dates: ["2024-05-18"]
---

# ydata-profilingの使い方

## 概要
 - `ydata-profiling`はデータの概要を確認するためのライブラリ
 - 連続値では以下の情報を出力
   - `distinct(%)`, `missing(%)`, `infinite(%)`, `mean`, `max`, `min`, `std`
   - ヒストグラム、最頻値
 - 値同士のscatter plotを見るは重く、必要に応じて出力を無効化できる

## インストール

```console
$ pip install ydata-profiling
```

## 具体例

```python
import pandas as pd
from sklearn.datasets import load_iris
from ydata_profiling import ProfileReport


# Irisデータセットの読み込み
data = load_iris()
df = pd.DataFrame(data=data.data, columns=data.feature_names)
df['target'] = data.target

# プロファイルレポートの設定オプション
profile = ProfileReport(df,
                        title='Iris Data Profiling Report',
                        explorative=True,
                        interactions=None,  # Interactions(scatter plot)をスキップ
                        correlations=None)  # Correlationsをスキップ

# レポートをノートブックで表示
profile.to_notebook_iframe()
```

## 参考
 - [YData Profiling: Welcome](https://docs.profiling.ydata.ai/latest/)
