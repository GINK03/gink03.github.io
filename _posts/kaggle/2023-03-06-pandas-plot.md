---
layout: post
title: "pandas plot" 
date: 2023-03-06
excerpt: "pandasのplotの使い方"
kaggle: true
tag: ["python", "pandas", "plot"]
comments: false
sort_key: "2023-03-06"
update_dates: ["2023-03-06"]
---

# pandasのplotの使い方

## 概要
 - pandasは一部matplotをラップしており、pandasの関数から描画が可能である
 - 簡単な可視化であればpandasのplot関数で行える

## pandas.DataFrame.plot.hist
 - series, dataframeインスタンスに`hist`メソッドが存在し、描画が可能
 - `bins`はbinの数と分け方のリストのどちらも取れる

```python
ax = df["size"].hist(legend=False, bins=10) # 描画インスタンスが得られる
ax.set_xlabel("xlabel")
ax.set_ylabel("ylabel")
display(ax)
```

## pandas.DataFrame.plot.bar
 - `x`; 当てなければindexが使用される
 - `y`; Y軸の値
 - `rot`; X軸のラベルの回転
 - `figsize`; 画像の大きさ

```python
df = pd.DataFrame({'lab':['A', 'B', 'C'], 'val':[10, 30, 20]})
ax = df.plot.bar(x='lab', y='val', rot=90, figsize=(5,5))
display(ax)
```

---

## 参考
 - [pandas.DataFrame.plot/pandas.pydata.org](https://pandas.pydata.org/docs/reference/api/pandas.DataFrame.plot.html)
 - [pandas.DataFrame.hist/pandas.pydata.org](https://pandas.pydata.org/docs/reference/api/pandas.DataFrame.hist.html)
