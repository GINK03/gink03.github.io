---
layout: post
title: "pandas pivot"
date: 2022-09-09
excerpt: "pandas pivotのチートシート"
kaggle: true
tag: ["python", "pandas", "pivot", "チートシート"]
sort_key: "2022-09-09"
update_dates: ["2022-09-09"]
comments: false
---

# pandas pivotのチートシート

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

---

## valuesの引数が複数になる場合
 - `aggfunc`でどのように集約するかを決める必要がある

**具体例**
```python
df.pivot(index=["os", "date"], columns=["source"], values=["any duplicatable value"])
```

### pivotした結果、index名とかが指定できなくなるとき

```python
df.columns = df.columns.to_series().str.join('_')
```
