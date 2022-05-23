---
layout: post
title: "factorial, permutation, combination"
date: 2021-05-22
excerpt: "factorial, permutaion, combinationについて"
computer_science: true
hide_from_post: true
tag: ["algorithm", "math", "integer", "combination", "permutaion", "factorial"]
comments: false
sort_key: "2021-05-24"
update_dates: ["2021-05-24","2021-05-22"]
---

# factorial, permutaion, combinationについて
MODを含む計算の時、標準関数では遅いため独自に実装する方針が有効である  

## python

```python
N = 10 ** 6  # N は必要分だけ用意する
MOD = 10 ** 9 + 7

class Wrap():
    def __init__(self):
        self.fact = [1, 1]  # fact[n] = (n! mod p)
        self.factinv = [1, 1]  # factinv[n] = ((n!)^(-1) mod p)
        self.inv = [0, 1]  # factinv 計算用
        for i in range(2, N + 1):
            self.fact.append((self.fact[-1] * i) % MOD)
            self.inv.append((-self.inv[MOD % i] * (MOD // i)) % MOD)
            self.factinv.append((self.factinv[-1] * self.inv[-1]) % MOD)
    def cmb(self, n, r):
        if (r < 0) or (n < r):
            return 0
        r = min(r, n - r)
        return self.fact[n] * self.factinv[r] * self.factinv[n-r] % MOD

wrap = Wrap()

# 使用例
a,b = map(int,input().split())
a-=1; b-=1
print(wrap.cmb(a+b, b))
```

--- 

### 例; 重複組み合わせ(H)を使って解答を得る

**問題**  
[AtCoder Beginner Contest 021; D - 多重ループ](https://atcoder.jp/contests/abc021/tasks/abc021_d)  
**解説**  
単純な組み合わせではなくて重複組み合わせが答えになる例  
同じ数がk回まで登場していいので `nHk`という式になるのであるが、これは`n+k-1Ck`と等価である  
**解答**  
```python
N = 10 ** 6  # N は必要分だけ用意する
MOD = 10 ** 9 + 7

class Wrap():
    def __init__(self):
        self.fact = [1, 1]  # fact[n] = (n! mod p)
        self.factinv = [1, 1]  # factinv[n] = ((n!)^(-1) mod p)
        self.inv = [0, 1]  # factinv 計算用
        for i in range(2, N + 1):
            self.fact.append((self.fact[-1] * i) % MOD)
            self.inv.append((-self.inv[MOD % i] * (MOD // i)) % MOD)
            self.factinv.append((self.factinv[-1] * self.inv[-1]) % MOD)
    def cmb(self, n, r):
        if (r < 0) or (n < r):
            return 0
        r = min(r, n - r)
        return self.fact[n] * self.factinv[r] * self.factinv[n-r] % MOD
wrap = Wrap()
n=int(input())
k=int(input())
print(wrap.cmb(n+k-1,k))
```
