---
layout: post
title: "cppのoptional"
date: 2022-06-30
excerpt: "cppのoptionalの使い方"
tags: ["c++", "cpp", "optional"]
config: true
comments: false
sort_key: "2022-06-30"
update_dates: ["2022-06-30"]
---

# cppのoptionalの使い方

## 概要
 - `#include <optional>`が必要
 - 型は`std::optional<T>`
 - 値がある場合は、`t.values()`で実態を取り出すことができる
 - 無いを示すのが`std::nullopt`

## 具体例

```cpp
#include <iostream>
#include <optional>
using namespace std;

optional<int> multiple(int x) {
    if(x >= 0)
        return x;
    else
        return nullopt;
}

int main() {
    auto ret0 = multiple(2);
    if(ret0)
        cout << ret0.value() << endl;
    auto ret1 = multiple(-1);
    if(!ret1)
        cout << "nulloptです" << endl;
}
```

## 参考
 - [std::optional/C++日本語リファレンス](https://cpprefjp.github.io/reference/optional/optional.html)
