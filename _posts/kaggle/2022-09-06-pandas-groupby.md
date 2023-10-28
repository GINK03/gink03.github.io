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
 - aggで指定する関数の引数はseriesになる
 - functools.reduce等をラップして関数を定義する

**具体例**
```python
def nsum(series):
    return functools.reduce(lambda x,y: x + "。 " + y, series)
tweet_agg = tweet.groupby(by=["screen_name", "user_id"]).agg(tweet_text=("tweet_text", nsum)).reset_index()
```
 - tweet_text(str)をコンキャットする例

## aggregationした値をリストで保持する
 - 要約しないでlistデータで維持する方法
 - [pandas-agg-list-example](https://colab.research.google.com/drive/1_l_Dx76i_BmMQSoW_H8L8iluDc0ty-BE?usp=sharing)

**具体例**
```python
df["A"] = [random.choice(["a", "b", "c"]) for i in range(100) ]
df["B"] = list(range(100))

display(df.groupby(by=["A"]).agg(B_lst=("B", list)).reset_index())
"""
0	a	[4, 5, 7, 10, 12, 16, 17, 18, 22, 25, 28, 31, ...
1	b	[0, 1, 2, 8, 9, 13, 15, 21, 24, 26, 27, 29, 30...
...
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
