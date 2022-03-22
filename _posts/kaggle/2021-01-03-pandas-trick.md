---
layout: post
title: "pandas trick"
date: 2021-01-03
excerpt: "pandasの様々なトリック"
project: false
kaggle: true
hide_from_post: true
tag: ["python", "pandas"]
comments: false
---

# pandasの様々なトリック

## 概要
 - メモリトリック

## バイト数の考え方
 - strは一文字1byteである
 - int8は1byte
 - int32は4byte
   - 最大値は2147483647
 - int64は8byte
   - 最大値は9,223,372,036,854,775,807

## ハッシュ値をint64でハンドルする
 
```python
df["digest"] = df["digest"].apply(lambda x: int(x[-16:],16)).astype("int64")
```
 - 大抵の値はこれで1/8程度のメモリに変換できる

## datetime型をyear, month, dayの粒度でハンドルする

```python
df["dt"] = pd.to_datetime(df["dt"])
df["year"] = (df["dt"].dt.year-2000).astype("int8")
df["month"] = (df["dt"].dt.month).astype("int8")
df["day"] = (df["dt"].dt.day).astype("int8")
del df["dt"]
```
 - 1/3程度にメモリを節約
