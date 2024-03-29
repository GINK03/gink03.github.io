---
layout: post
title: "segment tree"
date: 2021-05-07
excerpt: "segment tree(セグメント木)について"
computer_science: true
hide_from_post: true
tag: ["algorithm", "data structure", "segment tree"]
comments: false
sort_key: "2021-06-05"
update_dates: ["2021-06-05","2021-06-04","2021-05-29","2021-05-07"]
---

# segment tree(セグメント木)について
逐次計算すると計算コストが高いものに対して事前に分割して計算しておくことにより、利用時に計算コストを下げる  
計算はモノイドという結合律と単位元がある場合の計算になる  
 - メモ化の一種
 - 2で割っていくので、計算量は`O(n log n)`
 - 実装が非常に長いのでコピペできるようにする
 
## 基底の種類
 - `xor`, `gcd`, `add`, `or` -> `0`
 - `times(*)`, `lcm` -> `1`
 - `min` -> `inf`
 - `max` -> `-inf`
 - `matrix` -> `単位行列`

## 自分で基底を定義する
加法などの条件を満たせそうなデータ構造として解釈できる時、自分で`__add__`を定義してセグ木に当てはめることができる  
累積和や累積なんとかなどで解くときの代替手法としても使える  
 - [参考](https://atcoder.jp/contests/abc098/tasks/arc098_a)

```python
N = int(input())
S = input()

class E:
    def __init__(self, e, w):
        self.E = e
        self.W = w
    def __add__(self, other):
        return E(e=self.E + other.E, w=self.W+other.W)
    def __repr__(self):
        return f"E={self.E}, W={self.W}"
e = E(0, 0)
A = [E(e=0, w=1) if s == "W" else E(e=1, w=0) for s in S]
OP = lambda x,y:x+y
stree = Segtree(V=A, OP=OP, E=e )
ans = float('inf')
for i in range(N):
    right = stree.prod(i+1, N)
    left = stree.prod(0, i)
    ans = min(ans, right.E + left.W)
print(ans)
```

## 参考
 - [ACL-for-python](https://github.com/shakayami/ACL-for-python/blob/master/segtree.py)
   - [使い方](https://github.com/shakayami/ACL-for-python/wiki/segtree)
 - [Qiita; 非再帰型Segment TreeのPythonによる実装](https://qiita.com/dn6049949/items/afa12d5d079f518de368)  


## 例; xorを区間で求める
**問題**  
[AtCoder Beginner Contest 185; F - Range Xor Query](https://atcoder.jp/contests/abc185/tasks/abc185_f)  

**解説**  
基底の定義を間違えなければ簡単  

**解答**  
```python
class Segtree:
    n = 1
    size = 1
    log = 2
    d = [0]
    op = None
    e = 10 ** 15
    def __init__(self, V: "List", OP: "function", E: "基底"):
        self.n = len(V)
        self.op = OP
        self.e = E
        self.log = (self.n - 1).bit_length()
        self.size = 1 << self.log
        self.d = [E for i in range(2 * self.size)]
        for i in range(self.n):
            self.d[self.size + i] = V[i]
        for i in range(self.size - 1, 0, -1):
            self.update(i)
    def set(self, p, x): # 1
        assert 0 <= p and p < self.n
        p += self.size
        self.d[p] = x
        [self.update(p >> i) for i in range(1, self.log + 1)]
    def get(self, p): # 2
        assert 0 <= p and p < self.n
        return self.d[p + self.size]
    def prod(self, l, r): # 3
        assert 0 <= l and l <= r and r <= self.n
        sml = smr = self.e
        l += self.size; r += self.size
        while l < r:
            if l & 1:
                sml = self.op(sml, self.d[l])
                l += 1
            if r & 1:
                smr = self.op(self.d[r - 1], smr)
                r -= 1
            l >>= 1; r >>= 1
        return self.op(sml, smr)
    def all_prod(self): # 4
        return self.d[1]
    def max_right(self, l, f): # 5
        assert 0 <= l and l <= self.n
        assert f(self.e)
        if l == self.n:
            return self.n
        l += self.size
        sm = self.e
        while 1:
            while l % 2 == 0:
                l >>= 1
            if not (f(self.op(sm, self.d[l]))):
                while l < self.size:
                    l = 2 * l
                    if f(self.op(sm, self.d[l])):
                        sm = self.op(sm, self.d[l])
                        l += 1
                return l - self.size
            sm = self.op(sm, self.d[l])
            l += 1
            if (l & -l) == l:
                break
        return self.n
    def min_left(self, r, f): # 6
        assert 0 <= r and r < self.n
        assert f(self.e)
        if r == 0:
            return 0
        r += self.size
        sm = self.e
        while 1:
            r -= 1
            while r > 1 & (r % 2):
                r >>= 1
            if not (f(self.op(self.d[r], sm))):
                while r < self.size:
                    r = 2 * r + 1
                    if f(self.op(self.d[r], sm)):
                        sm = self.op(self.d[r], sm)
                        r -= 1
                return r + 1 - self.size
            sm = self.op(self.d[r], sm)
            if (r & -r) == r:
                break
        return 0
    def update(self, k): # 7
        self.d[k] = self.op(self.d[2 * k], self.d[2 * k + 1])
        
import math
N,Q = map(int, input().split())
*A, = map(int, input().split())
op = lambda l,r: l^r
st = Segtree(A, op, 0)
qs =[]
for q in range(Q):
    *q,=map(int,input().split())
    qs.append(q)
for t,x,y in qs:
    if t==1:
        st.set(x-1, st.get(x-1) ^ y)
    else:
        print(st.prod(x-1,y))
```

## 例; 特定の要素を外すと最大になる
[AtCoder Beginner Contest 125; C - GCD on Blackboard](https://atcoder.jp/contests/abc125/tasks/abc125_c)

**解説**  
特定の要素を考慮しないことを、"特定の要素の範囲外の最大公約数"と読み替える  
最大公約数の計算は結合律が存在する操作なので行ける  

**回答**
```python
class segtree():
    n=1
    size=1
    log=2
    d=[0]
    op=None
    e=10**15
    def __init__(self,V,OP,E):
        self.n=len(V)
        self.op=OP
        self.e=E
        self.log=(self.n-1).bit_length()
        self.size=1<<self.log
        self.d=[E for i in range(2*self.size)]
        for i in range(self.n):
            self.d[self.size+i]=V[i]
        for i in range(self.size-1,0,-1):
            self.update(i)
    def set(self,p,x):
        assert 0<=p and p<self.n
        p+=self.size
        self.d[p]=x
        for i in range(1,self.log+1):
            self.update(p>>i)
    def get(self,p):
        assert 0<=p and p<self.n
        return self.d[p+self.size]
    def prod(self,l,r):
        assert 0<=l and l<=r and r<=self.n
        sml=self.e
        smr=self.e
        l+=self.size
        r+=self.size
        while(l<r):
            if (l&1):
                sml=self.op(sml,self.d[l])
                l+=1
            if (r&1):
                smr=self.op(self.d[r-1],smr)
                r-=1
            l>>=1
            r>>=1
        return self.op(sml,smr)
    def all_prod(self):
        return self.d[1]
    def max_right(self,l,f):
        assert 0<=l and l<=self.n
        assert f(self.e)
        if l==self.n:
            return self.n
        l+=self.size
        sm=self.e
        while(1):
            while(l%2==0):
                l>>=1
            if not(f(self.op(sm,self.d[l]))):
                while(l<self.size):
                    l=2*l
                    if f(self.op(sm,self.d[l])):
                        sm=self.op(sm,self.d[l])
                        l+=1
                return l-self.size
            sm=self.op(sm,self.d[l])
            l+=1
            if (l&-l)==l:
                break
        return self.n
    def min_left(self,r,f):
        assert 0<=r and r<self.n
        assert f(self.e)
        if r==0:
            return 0
        r+=self.size
        sm=self.e
        while(1):
            r-=1
            while(r>1 & (r%2)):
                r>>=1
            if not(f(self.op(self.d[r],sm))):
                while(r<self.size):
                    r=(2*r+1)
                    if f(self.op(self.d[r],sm)):
                        sm=self.op(self.d[r],sm)
                        r-=1
                return r+1-self.size
            sm=self.op(self.d[r],sm)
            if (r& -r)==r:
                break
        return 0
    def update(self,k):
        self.d[k]=self.op(self.d[2*k],self.d[2*k+1])

import math
N = int(input())
*A, = map(int, input().split())

st = segtree(A, math.gcd, 0)

ans = []
for i in range(0, N):
    if i == 0:
        res = st.prod(1, N)
    elif i == N-1:
        res = st.prod(0, N-1)
    else:
        res = math.gcd(st.prod(0, i), st.prod(i+1, N))
        # print( st.prod(0, i), st.prod(i+1, N))
    ans.append(res)

print(max(ans))
```


## 例; 毎回範囲を判定するような場合のカウント

**問題**  
[ACL Beginner Contest; D - Flat Subsequence](https://atcoder.jp/contests/abl/tasks/abl_d)  

**解説**  
題意を満たす最大の数をカウントすると読み替える  
毎回、与えられた数字`A`の周辺`K`のカウントを行う  
素直に考えると `O(n*m)`かかるが、`segtree`を用いることで計算量を圧縮できる  

**解答**  
[submission](https://atcoder.jp/contests/abl/submissions/22982130)  


## 例; 範囲内の最小値を求める問題  

**問題**  
[No.875 Range Mindex Query](https://yukicoder.me/problems/no/875)  

**解説**  
セグメント木はインデックス情報を返せないので一工夫入れる必要がる  

**解答**  
[submission](https://yukicoder.me/submissions/661815)  

