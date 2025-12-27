---
layout: post
title: "seaborn 箱ひげ図(boxplot)"
date: 2023-02-06
excerpt: "seabornの箱ひげ図(boxplot)"
tags: ["seaborn", "python", "matplotlib", "可視化", "boxplot", "箱ひげ図"]
kaggle: true
comments: false
sort_key: "2023-02-06"
update_dates: ["2023-02-06"]
---

# seabornの箱ひげ図(boxplot)

## 概要
 - デフォルトの仕様で外れ値も描画するので`ax.set(ylim=~)`などで制限する
 - 対数スケールになってしまうときは`ax.set_yscale("linear")`でリニアスケールに設定できる
 - カテゴリの並び順を固定したい場合は`order`引数で順序を指定する
 
## 具体例

### pandasのdataframeを期待するとき

```python
ax = sns.boxplot(data=df, x="menu", y="value")
ax.set_yscale("linear")
ax.set(ylim=(0, 200000))
display(ax)
```

### カテゴリ順序を指定する場合

```python
order = ["menu_a", "menu_b", "menu_c"]
ax = sns.boxplot(data=df, x="menu", y="value", order=order)
ax.set_yscale("linear")
ax.set(ylim=(0, 200000))
display(ax)
```

---

## 参考
 - [seaborn.boxplot/seaborn.pydata.org](https://seaborn.pydata.org/generated/seaborn.boxplot.html)
