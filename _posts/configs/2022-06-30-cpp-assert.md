---
layout: post
title: "cppのassert"
date: 2022-06-30
excerpt: "cppのassertの使い方"
tags: ["c++", "cpp", "assert"]
config: true
comments: false
sort_key: "2022-06-30"
update_dates: ["2022-06-30"]
---

# cppのassertの使い方

## 概要
 - `#include <cassert>`を使用する
 - assertの条件に一致しない場合、異常終了する(プロセスのステータスコードが0ではない値になる)

## 具体例

```cpp
#include <cassert>

int main() {
    int a = 10;
    assert(a == 10); // 期待する値と等しければ正常に進む
    assert(a == -1); // echo $? -> 134
}
```

## 参考
 - [assert/C++日本語リファレンス](https://cpprefjp.github.io/reference/cassert/assert.html)
