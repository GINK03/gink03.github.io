---
layout: post
title: "pandas query"
date: 2021-01-03
excerpt: "pandas queryのチートシート"
tag: ["python", "pandas", "チートシート"]
kaggle: true
sort_key: "2022-05-30"
update_dates: ["2022-05-30"]
comments: false
---

# pandas queryのチートシート

## 概要
 - 複雑なフィルタを簡単に記す機能
 - 文字列を引数にとってSQL likeに処理することができる

## 各機能の説明

### 特定の値でフィルタする

```python
df.query('column > 10.0')
```

### 特定の値でフィルタした結果でdfを置き換える

```python
df.query('column > 10.0', inplace=True)
```

### 外部の変数を参照してフィルタする

```python
val = 10.0
df.query('column > @val')
```

### listの値が含まれているものをフィルタする

```python
lst = [1, 2, 3]
df.query('column in @lst')
```

### NaNでない値でフィルタ

```python
df.query('column.notna()')
```

### NaNである値でフィルタ

```python
df.query('column.isna()')
```

### nullでない値でフィルタ

```python
df.query('column.notnull()')
```

### nullである値でフィルタ

```python
df.query('column.isnull()')
```

### 文字列の正規表現でフィルタ

```python
df.query('column.str.contains("something", regex=True)')
```

### スペースで区切られたカラム名の操作

```python
df = pd.DataFrame({"a b c": [1, 2, 3], "value": [4, 5, 6]})
df.query('`a b c` >= 2')

"""
|    |   a b c |   value |
|---:|--------:|--------:|
|  1 |       2 |       5 |
|  2 |       3 |       6 |
"""
```
