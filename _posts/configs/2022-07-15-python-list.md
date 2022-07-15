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

## 明示的に参照渡しにする

```python
def func(lst):
  lst[:] = [1, 2, 3]
```

## インデックスアクセス
 - 左からi番目にアクセスするには`lst[i]`
 - 右からi番目にアクセスするには`lst[~i]`
   - `~i`はビットを反転したもので、`-i-1`と同義
