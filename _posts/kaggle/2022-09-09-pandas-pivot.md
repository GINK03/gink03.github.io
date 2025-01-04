---
layout: post
title: "pandas pivot"
date: 2022-09-09
excerpt: "pandas pivotのチートシート"
kaggle: true
tag: ["python", "pandas", "pivot", "pivot_table", "チートシート"]
sort_key: "2022-09-09"
update_dates: ["2022-09-09"]
comments: false
---

# pandas pivotのチートシート

## pivotとpivot_tableの違い
 - `pivot_table`は`pivot`の一般化
 - `pivot_table`はaggregation関数を使えたり、`fill_value`を使える

## pivot
 - 特定のrowのvalueをcolumnにする
 - `index`, `columns`, `values`を指定する

e.g. 全世界の年ごとのドクターの数

```python
import pandas as pd
df = pd.read_csv("medicalDoctors.csv")
df.pivot(index=["Location"], columns=["Period"], values=["First Tooltip"])
```

### pivotした結果、multilevelになったcolumnをdropする

```python
df.columns = df.columns.droplevel()
```

### pivotした結果、index名とかが指定できなくなるとき

```python
df.columns = df.columns.to_series().str.join('_')
```


## pivot_tableでvaluesの引数が複数になる場合
 - `aggfunc`でどのように集約するかを決める必要がある

**具体例**
```python
df.pivot_table(index=["os", "date"], 
              columns=["source"], 
              values=["any duplicatable value"],
              aggfunc=np.mean) # 平均を取る場合
```

## 様々なaggfunc

```python
# サンプルデータの作成
data = {
    '商品': ['A', 'B', 'A', 'B', 'A', 'B'],
    '地域': ['東', '東', '西', '西', '東', '西'],
    '売上': [100, 150, 200, 250, 300, 350],
    '数量': [10, 15, 20, 25, 30, 35]
}

df = pd.DataFrame(data)

# ピボットテーブルの作成
pivot = pd.pivot_table(
    df,
    index='商品',               # 行に設定する列
    columns='地域',             # 列に設定する列
    values=['売上', '数量'],    # 集計対象の値
    aggfunc={
        '売上': 'sum',          # 売上の合計
        '数量': ['mean', 'first']  # 数量の平均と最初の値
    }
)
```

## pivot_tableで存在しないデータの値を埋める
 - `pivot_table`関数の`fill_value`引数に値を指定することで、存在しない値を埋めることができる

```python
df.pivot_table(index=["date", "os"], columns=["source"], values=["value_column"], fill_value=0.0)
```

---

## 参考
 - [Pandas Pivot — The Ultimate Guide/medium](https://towardsdatascience.com/pandas-pivot-the-ultimate-guide-5c693e0771f3#:~:text=Pandas%20has%20a%20pivot_table%20function,,%20which%20calculates%20the%20average).)
 - [Pandas: Difference between pivot and pivot_table. Why is only pivot_table working?/stackoverflow](https://stackoverflow.com/questions/30960338/pandas-difference-between-pivot-and-pivot-table-why-is-only-pivot-table-workin)
