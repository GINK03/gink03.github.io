---
layout: post
title: "pandas setting with copy warning" 
date: 2023-05-25
excerpt: "pandasのsetting with copy warning"
kaggle: true
tag: ["python", "pandas", "warning", "setting with copy warning"]
comments: false
sort_key: "2023-05-25"
update_dates: ["2023-05-25"]
---

# pandasのsetting with copy warningの概要

## 概要
 - pandasのdataframeのインスタンスが参照で変更されたのか、コピーで変更されたのか確信が持てない時に出る警告

## 具体例

### 警告が出る例

```python
df = pd.DataFrame({'A': [1, 2, 3], 'B': [4, 5, 6]})
df_slice = df[df['A'] > 1]
df_slice['B'] = 0  # SettingWithCopyWarning が発生
```

### 警告が出ない例

```python
df = pd.DataFrame({'A': [1, 2, 3], 'B': [4, 5, 6]})
df.loc[df['A'] > 1, 'B'] = 0  # SettingWithCopyWarning が発生しない
```
