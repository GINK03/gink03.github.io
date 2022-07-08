---
layout: post
title: "cppのvector"
date: "2022-07-08"
excerpt: "cppのvectorの使い方"
config: true
tag: ["cpp", "vector"]
comments: false
sort_key: "2022-07-08"
update_dates: ["2022-07-08"]
---

# cppのvectorの使い方

## 概要
 - std
 - `sort`, `reverse`は`<algorithm>`に内包されている

## 具体例

### 初期化

```cpp
vector<int> a{1, 2, 3, 4, 5};
vector<int> b(100, 0); // 100の長さで、0で初期化
```

### 反転

```cpp
vector<int> a{1,2,3};
reverse(a.begin(), a.end());
```

### ソート

```cpp
vector<int> a{3,2,1};
sort(a.begin(), a.end());
```

## 参考
 - [std::sort/cpprefjp - C++日本語リファレンス](https://cpprefjp.github.io/reference/algorithm/sort.html)
 - [std::reverse/cplusplus.com](https://m.cplusplus.com/reference/algorithm/reverse/)

