---
layout: post
title: "cppのrandom"
date: 2022-07-01
excerpt: "cppのrandomの使い方"
tags: ["c++", "cpp", "random"]
config: true
comments: false
sort_key: "2022-07-01"
update_dates: ["2022-07-01"]
---

# cppのrandomの使い方

## 概要
 - 非決定性のランダムと高速に計算できるが決定性のランダム等がある
 - `#include <random>`すると用いることができる

## 具体例

```cpp
#include <random>
#include <iostream>
#include <cassert>

using namespace std;
int main()
{
    std::random_device rnd;
    // デバイスから生成される非決定的な乱数
    cout << rnd() << endl;
    std::mt19937 mt(rnd());
    // 非決定的な値をシードとしてメルセンヌ・ツイスタで疑似乱数
    cout << mt() << endl;

    std::mt19937 gen32;
    std::mt19937_64 gen64;
    for (auto n = 1; n != 10'000; gen32(), gen64(), ++n);
    // 決定性のランダムだから初期値が一緒だと10000回目の値がわかる
    assert(gen32() == 4'123'659'995 and
           gen64() == 9'981'545'732'273'789'042ULL);
}
```

## 参考
 - [std::mersenne_twister_engine/cppreference.com](https://en.cppreference.com/w/cpp/numeric/random/mersenne_twister_engine)
 - [C++11 乱数 std::random 入門](http://vivi.dyndns.org/tech/cpp/random.html)
