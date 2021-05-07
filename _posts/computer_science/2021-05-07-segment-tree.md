---
layout: post
title: "segment tree"
date: 2021-05-07
excerpt: "segment tree(セグメント木)について"
computer_science: true
hide_from_post: true
tag: ["algorithm", "data structure", "segment tree"]
comments: false
---

# segment tree(セグメント木)について
逐次計算すると計算コストが高いものに対して事前に分割して計算しておくことにより、利用時に計算コストを下げる  
計算はモノイドという結合律と単位元がある場合の計算になる  

**感想**
 - メモ化の一種に見える
 - 2で割っていくので、計算量は`O(n log n)`

## 参考
[Qiita; 非再帰型Segment TreeのPythonによる実装](https://qiita.com/dn6049949/items/afa12d5d079f518de368)  

## 例; 特定の要素を外すと最大になる
[AtCoder Beginner Contest 125; C - GCD on Blackboard](https://atcoder.jp/contests/abc125/tasks/abc125_c)

**解説**  
特定の要素を考慮しないことを、"特定の要素の範囲外の最大公約数"と読み替える  
最大公約数の計算は結合律が存在する操作なので行ける  

**回答**
```python
class SegmentTree:
    def __init__(self, size_n, func=lambda x,y : x+y, default=0):
        self.size_n = 2**(size_n-1).bit_length() # 多次元のテーブルの大きさ
        self.default = default
        self.dat = [default]*(self.size_n*2-1) # 多次元のテーブル
        self.func = func

    def update(self, i, x):
        i += self.size_n-1 # iを一番右側の次元(ボトムのテーブル)に指定
        self.dat[i] = x # 最初に指定された値を入れる
        while i > 0:
            i = (i-1) >> 1 # 左の次元に寄る
            self.dat[i] = self.func(self.dat[i*2+1], self.dat[i*2+2]) # 右の次元から左の次元の内容を計算

    def query(self, l, r, k=0, L=0, R=None):
        if R is None:
            R = self.size_n
        if R <= l or r <= L:
            return self.default
        if l <= L and R <= r:
            return self.dat[k]
        else:
            lres = self.query(l, r, k*2+1, L, (L+R) >> 1) # 探索範囲をシフト
            rres = self.query(l, r, k*2+2, (L+R) >> 1, R) # 探索範囲をシフト
            return self.func(lres, rres)

def gcd(a, b):
    if a == 0:
        return b
    else:
        return gcd(b%a, a)

N = int(input())
A = list(map(int, input().split()))
st = SegmentTree(size_n=N, func=gcd)
for i in range(N):
    st.update(i, A[i])

ans = 1
for i in range(N):
    left = st.query(0, i)
    right = st.query(i+1, N)
    ans = max(ans, gcd(left, right))
print(ans)
```
