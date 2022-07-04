---
layout: post
title: "cppのpriority_que"
date: 2022-07-04
excerpt: "cppのpriority_queの使い方"
tags: ["c++", "cpp", "priority_que"]
config: true
comments: false
sort_key: "2022-07-04"
update_dates: ["2022-07-04"]
---

# cppのpriority_queの使い方

## 概要
 - pythonのheapqに相当するライブラリ
   - listをラップした形ではなくてC++は専用のデータ構造が用意されている
 - 大きい値順に取り出すことができるが、自分で比較関数を記述することで自由に設計することができる

## 具体例

```cpp
#include <iostream>
#include <queue>
#include <cassert>
using namespace std;

int main()
{
  priority_queue<int> que;

  que.push(3);
  que.push(1);
  que.push(4);

  assert(que.top() == 4);
  que.pop();
  assert(que.top() == 3);
  que.pop();
  assert(que.top() == 1);
  que.pop();
  assert(que.empty() == true);
}
```

## 参考
 - [std::priority_queue/cpprefjp - C++日本語リファレンス](https://cpprefjp.github.io/reference/queue/priority_queue.html)
