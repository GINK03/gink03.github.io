---
layout: post
title: "pandas groupby"
date: 2022-09-06
excerpt: "pandas groupbyのチートシート"
kaggle: true
tag: ["python", "pandas", "groupby", "チートシート"]
sort_key: "2022-09-06"
update_dates: ["2022-09-06"]
comments: false
---

# pandas groupbyのチートシート

## groupby関数で得られるオブジェクト
 - データフレームを特定のキーでグルーピングする
   - groupしたオブジェクトを取り出す
     - `grp_df = df.groupby(by=["key"])`
   - group時のキーの一覧
     - `grp_df.groups.keys()`
   - group時のバリューの一覧
     - `grp_df.groups.values()`
   - 特定のキーのdataframeの取得
     - `df = grp_df.get_group("a")`
 - 具体例
   - [pd-group-example](https://colab.research.google.com/drive/1LZWraVv7P48ym_PWJwFwUxSchq0ziBN9?usp=sharing)

## カスタムaggregation functionを用いる

**具体例**
```python
df = pd.DataFrame()
df["Category"] = [np.random.choice(["a", "b", "c"]) for i in range(10)]
df["Value"] = list(range(10))

def custom_sum(series: pd.Series):
    return sum([x for x in series.tolist() if x%2 == 0])
    
grouped = df.groupby(by=["Category"]).agg(custom_sum=("Value", custom_sum)).reset_index()

"""
| Category   |   custom_sum |
|:-----------|-------------:|
| a          |           20 |
| b          |            0 |
| c          |            0 |
"""
```

## aggregationした値をリストにする

**具体例**
```python
df = pd.DataFrame()
df["Category"] = [np.random.choice(["a", "b", "c"]) for i in range(10)]
df["Value"] = list(range(10))

grouped = df.groupby(by=["Category"]).agg(lst=("Value", list)).reset_index()

"""
| Category   | lst             |
|:-----------|:----------------|
| a          | [2, 3, 8]       |
| b          | [4, 5]          |
| c          | [0, 1, 6, 7, 9] |
"""
```

## aggregationした値の最頻値を取得する

**具体例**
```python
import pandas as pd

# サンプルデータの作成
data = {
    'Category': ['A', 'A', 'A', 'B', 'B', 'C', 'C', 'C', 'C'],
    'Value': [1, 2, 2, 3, 3, 4, 4, 4, 5]
}
df = pd.DataFrame(data)

# グループごとの最頻値を計算
mode_df = df.groupby(by=['Category']).agg(value_mode=('Value', lambda x: x.mode().iloc[0])).reset_index()
"""
| Category   |   value_mode |
|:-----------|-------------:|
| A          |            2 |
| B          |            3 |
| C          |            4 |
"""
```

## groupbyした上でsamplingする
 - 各グループで同じだけのサンプルが欲しい場合などに使える
 - 戻り値は`pd.DataFrame`
 - `random_state`オプションを設定することで再現性を確保できる

**具体例**
```python
# 各日で100000を条件にサンプルする例
df = df.groupby(by=["day"]).sample(n=100000, random_state=1)
```

## groupbyした上でrollingする
 - 各グループでrollingしたい場合に使える
 - `transform`を使うことで、rollingした値を元のデータフレームに追加できる
   - `transform`を用いないとグループ間の境界を考慮しない

**具体例**
```python
# 各グループでrollingした値を元のデータフレームに追加する例
df["rolling_mean"] = df.groupby(by=["group name"])["value"].transform(lambda x: x.rolling(7, 1).mean())
```

## groupbyした上でテキストを結合する

**具体例**
```python
data = {
    'Category': ['A', 'A', 'B', 'B', 'C', 'C'],
    'Text': ['apple', 'banana', 'cherry', 'date', 'elderberry', 'fig'],
}
df = pd.DataFrame(data)
grouped = df.groupby('Category').agg({'Text': ', '.join}).reset_index()

"""
| Category   | Text            |
|:-----------|:----------------|
| A          | apple, banana   |
| B          | cherry, date    |
| C          | elderberry, fig |
"""
```
