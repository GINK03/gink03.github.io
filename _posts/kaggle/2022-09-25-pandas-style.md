---
layout: post
title: "pandas style"
date: 2022-09-25
excerpt: "pandas styleのチートシート"
kaggle: true
tag: ["python", "pandas", "チートシート"]
sort_key: "2022-09-25"
update_dates: ["2022-09-25"]
comments: false
---

# pandas styleのチートシート

## 概要
 - notebookで可視化する際にスタイルを整えるのに必要 
 - builder patternになっている

## 関数
 - `format`
   - 桁数や文字のトリム
 - `highlight_max`
   - 最大値に色を付ける
 - `highlight_min`
   - 最小値に色を付ける
 - `hide`
   - インデックスを非表示(1.3.0以降から)
 - `background_gradient(cmap='Blues')`
   - ヒートマップ

## 具体例

```python
df.head(10).style.format({"BasePay": "${:20,.0f}", 
                          "OtherPay": "${:20,.0f}", 
                          "TotalPay": "${:20,.0f}",
                          "TotalPayBenefits":"${:20,.0f}"}) \
                 .format({"JobTitle": lambda x:x.lower(), "EmployeeName": lambda x:x.lower()}) \
                 .hide() \ # 1.3.0からhide関数になった
                 .background_gradient(cmap='Blues')
```

## 参考
 - [Style Pandas Dataframe Like a Master](https://towardsdatascience.com/style-pandas-dataframe-like-a-master-6b02bf6468b0)
