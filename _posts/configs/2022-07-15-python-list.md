---
layout: post
title: "python list" 
date: "2022-07-15"
excerpt: "python listの使い方"
config: true
tag: ["python", "list"]
comments: false
sort_key: "2022-07-15"
update_dates: ["2022-07-15"]
---

# python listの使い方

## 概要
 - C++のvectorに該当する
 - popが遅いので、多用する際は`deque`を使用する
 - コピー渡しと参照渡しが入り混じりになりやすい
 - python特有の機能として、listの評価がある
   - list同士の比較は内容まで見る
   - tupleのように順序付きで大小比較できる

## 明示的に参照渡しにする

```python
def func(lst):
  lst[:] = [1, 2, 3]
```

## インデックスアクセス
 - 左からi番目にアクセスするには`lst[i]`
 - 右からi番目にアクセスするには`lst[~i]`
   - `~i`はビットを反転したもので、`-i-1`と同義

## 評価と比較

### 評価

```python
assert [1,2,3] == [1,2,3]
```

### 比較

```python
assert [1,2,3] < [1,3,2]
```
