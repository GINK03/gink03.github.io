---
layout: post
title: "rolling hash"
date: 2021-05-31
excerpt: "ローリングハッシュについて"
computer_science: true
hide_from_post: true
tag: ["algorithm", "math", "rolling hash"]
comments: false
---

# rolling hashについて
 - C++等において高速に文字列の比較等をやりやすくする等のモチベーションで用いられる
 - 言うなれば、文字列のhash化をしているだけなのでpythonで同じものを実装する意味や意義はあまり大きくない 
   - `python 3.X`の文字列操作は非常に高速であり、rolling hashを用いなくても通る

## 実装例

```python
class RollingHash():
    def __init__(self, s, base = 1237, mod = ((1<<61)-1) ):
        '''
        modの大きさは以下のURLに最適値が記されている
        https://qiita.com/keymoon/items/11fac5627672a6d6a9f6
        '''
        l = len(s)
        self.mod = mod
        self.pw = pw = [1]*(l+1)
        self.h = h = [0]*(l+1)

        for i in range(l):
            h[i+1] = (h[i] * base + ord(s[i])) % mod
            pw[i+1] = pw[i] * base % mod
    def get(self, l, r):
        '''
        ある区間のhash値を返す
        '''
        return (self.h[r] - self.h[l] * self.pw[r-l]) % self.mod
```

## 実験例
 - [colab](https://colab.research.google.com/drive/1Fxk10t8sKlcHi59duSeySuBDb81VYHnI?usp=sharing)

## 例; C++でrolling hashが期待される問題(pythonでは問題が生じにくい)

**問題**  
[AtCoder Beginner Contest 141; E - Who Says a Pun?](https://atcoder.jp/contests/abc141/tasks/abc141_e)

**解答**  
```python
class RollingHash():
    def __init__(self, s, base = 1237, mod = ((1<<61)-1) ):
        '''
        modの大きさは以下のURLに最適値が記されている
        https://qiita.com/keymoon/items/11fac5627672a6d6a9f6
        '''
        l = len(s)
        self.mod = mod
        self.pw = pw = [1]*(l+1)
        self.h = h = [0]*(l+1)

        for i in range(l):
            h[i+1] = (h[i] * base + ord(s[i])) % mod
            pw[i+1] = pw[i] * base % mod
    def get(self, l, r):
        return (self.h[r] - self.h[l] * self.pw[r-l]) % self.mod

N = int(input())
S = input()
rh0 = RollingHash(S)

def check(n):
    tmp = {}
    for i in range(0, N-n+1):
        h0 = rh0.get(i, i+n)
        if h0 in tmp:
            if tmp[h0] <= i:
                return True
        else:
            tmp[h0] = i+n
    return False

def check2(n):
    # 実質 O(n^2)になるのでTLEする
    tmp = {}
    for i in range(0, N-n+1):
        tgt = S[i:i+n]
        if S.find(tgt, i+n) >= 0:
            return True
    return False

def check3(n):
    # OK
    tmp = {}
    for i in range(0, N-n+1):
        h0 = hash(S[i:i+n])
        if h0 in tmp:
            if tmp[h0] <= i:
                return True
        else:
            tmp[h0] = i+n
    return False

def check4(n):
    # OK
    tmp = {}
    for i in range(0, N-n+1):
        s0 = S[i:i+n]
        if s0 in tmp:
            if tmp[s0] <= i:
                return True
        else:
            tmp[s0] = i+n
    return False

ok = 0
ng = 10 ** 20
while True:
    mid = (ok + ng) // 2
    if check4(mid):
        ok = mid
    else:
        ng = mid
    if ng - ok == 1:
        break
print(ok)
```
