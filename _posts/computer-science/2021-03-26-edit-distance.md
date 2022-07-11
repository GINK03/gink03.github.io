---
layout: post
title: "edit distance"
date: 2021-03-26
excerpt: "edit distance(編集距離)について"
computer_science: true
hide_from_post: true
tag: ["edit distancce", "編集距離", "レーベンシュタイン距離", "algorithm", "dynamic programming"]
comments: false
sort_key: "2021-03-26"
update_dates: ["2021-03-26","2021-03-26"]
---

# edit distance(編集距離)について

## 概要
 - 編集距離
 - 動的計画法(dynamic programming)の例題としてよく出る

## 具体的な挙動
 1. ２つの文字にそれぞれ１づつ増える文字を与える
 2. (n+1)*(m+1)のマトリックスを構築する
 3. `置き換え, dp[i-1][k-1]+1`, `削除, dp[i-1][k]+1`, `挿入, dp[i][k-1]+1` or `一致時, dp[i-1][k-1]`の値を入れる
 4. いずれかのケースの最小値を代入する

## 図による例
<div>
  <img src="https://user-images.githubusercontent.com/4949982/112608691-f943b980-8e5d-11eb-928e-f16c0b89d588.png">
</div>

## pythonのコード

```python
import numpy 

def EditDistance(s1, s2):
    """ Computes the edit distance of two strings
    (str, str) -> (int, 2D-array) """
    ln_s1 = len(s1)
    ln_s2 = len(s2)

    # Initializing the matrix
    dp = [[float('inf')]*(ln_s2+1) for _ in range(ln_s1+1)]
    for i in range(ln_s2+1):
        dp[0][i] = i

    for i in range(ln_s1+1):
        dp[i][0] = i

    # Filling the matrix
    for i in range(1, ln_s1+1):
        for j in range(1, ln_s2+1):
            insertion = dp[i][j-1]   + 1
            deletion  = dp[i-1][j]   + 1
            mismatch  = dp[i-1][j-1] + 1
            match     = dp[i-1][j-1]
            if s1[i-1] == s2[j-1]:
                dp[i][j] = min(insertion, deletion, match)
            if s1[i-1] != s2[j-1]:
                dp[i][j] = min(insertion, deletion, mismatch)
    
    return (int(dp[ln_s1][ln_s2]), dp)
```

## 参考
 - [72. Edit Distance/LeetCode](https://leetcode.com/problems/edit-distance/)
 - [Edit distance](https://en.wikipedia.org/wiki/Edit_distance)
