---
layout: post
title: "pandas to numeric" 
date: 2025-02-16
excerpt: "pandas to numeric"
kaggle: true
tag: ["pandas"]
comments: false
sort_key: "2025-02-16"
update_dates: ["2025-02-16"]
---

# pandas to numeric

## 概要
 - pandasの `to_numeric` 関数は文字列を数値に変換する関数
 - `errors` 引数で変換できない場合の挙動を指定できる
   - `coerce` : 変換できない場合は `NaN` に変換
   - `ignore` : 変換できない場合はそのまま
   - `raise` : 変換できない場合はエラーを発生
 - `downcast` 引数でデータ型を指定でき、最小のデータ型に変換するのでメモリ効率が向上
   - `integer` : 整数型に変換
   - `signed` : 符号付き整数型に変換
   - `unsigned` : 符号なし整数型に変換
   - `float` : 浮動小数点型に変換
   - `object` : オブジェクト型に変換

## 具体例

**整数型に変換**

```python
import pandas as pd

# 数値の文字列を含むシリーズ
s = pd.Series(['1', '2', '3'])
numeric_s = pd.to_numeric(s)
print(numeric_s)
"""
0    1
1    2
2    3
dtype: int64
"""
```

**浮動小数点型に変換**

```python
import pandas as pd

s = pd.Series(['3.14', '2.718'])
# downcast='float' を指定すると、可能な場合は float32 に変換されます
numeric_s = pd.to_numeric(s, downcast='float')
print(numeric_s)
print(numeric_s.dtype)  # 型が float32 なら、メモリ節約に寄与
"""
0    3.140
1    2.718
dtype: float32
float32
"""
```

**ダウンキャスト**

```python
s = pd.Series(['1', '2', '3'])
numeric_s = pd.to_numeric(s, downcast='integer')
print(numeric_s.dtype)  # 出力例: int8、最小の整数型に変換
```

**変換できない場合の挙動**

```python
s = pd.Series(['1', '2', 'three'])
numeric_s = pd.to_numeric(s, errors='coerce')
print(numeric_s)
# 出力: [1.0, 2.0, NaN]
```


