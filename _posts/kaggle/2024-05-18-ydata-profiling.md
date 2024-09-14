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

**基本的な情報をiframeで表示**

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

**基本的な情報をpandas dataframeで表示**

```python
import pandas as pd
from ydata_profiling import ProfileReport
import json

# サンプルデータ
df = pd.DataFrame({
    'A': [1, 2, 3, 4, None],
    'B': ['a', 'b', 'c', 'd', 'e'],
    'C': [10.12345, None, 12.34567, 14.45678, 15.56789]
})

profile = ProfileReport(df, minimal=True)
profile_json = profile.to_json()
report_dict = json.loads(profile_json)
variables = report_dict["variables"]
summary_df = pd.DataFrame(variables).T
# 欠損値やユニークな値の数などを抽出
summary_df = summary_df[['count', 'n_missing', 'p_missing', 'n_unique', 'mean', 'std', 'min', 'max']]

summary_df
"""
|    |   count |   n_missing |   p_missing |   n_unique |     mean |       std |      min |      max |
|:---|--------:|------------:|------------:|-----------:|---------:|----------:|---------:|---------:|
| A  |       4 |           1 |         0.2 |          4 |   2.5    |   1.29099 |   1      |   4      |
| B  |       5 |           0 |         0   |          5 | nan      | nan       | nan      | nan      |
| C  |       4 |           1 |         0.2 |          4 |  13.1234 |   2.40541 |  10.1235 |  15.5679 |
"""
```

## 参考
 - [YData Profiling: Welcome](https://docs.profiling.ydata.ai/latest/)
