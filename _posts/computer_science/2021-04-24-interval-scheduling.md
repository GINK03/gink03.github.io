---
layout: post
title: "interval scheduling"
date: 2021-04-24
excerpt: "区間スケジューリングについて"
computer_science: true
hide_from_post: true
tag: ["algorithm", "greedy", "interval scheduling", "区間スケジューリング"]
comments: false
sort_key: "2021-04-24"
update_dates: ["2021-04-24"]
---

# 区間スケジューリング(interval scheduling)について
 - 貪欲法でよくある例題の一つにある
 - 開始時間と終了時間が定義されている時、最大の実行数を求める時
 - 終了日でソートして終了日が早い順にピックアップするのが最適解

## 具体例

[典型アルゴリズム問題集; B - 区間スケジューリング問題](B - 区間スケジューリング問題)  

```python
N = int(input())
BA = []
for i in range(N):
    a, b = map(int, input().split())
    BA.append([b,a])

BA = sorted(BA)
 
ans = 0
last = 0
 
for b, a in BA:
    if last < a:
        ans += 1
        last = b
print(ans)
```
