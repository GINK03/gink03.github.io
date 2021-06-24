---
layout: post
title: "binary search"
date: 2020-11-06
excerpt: "binary searchについて"
project: false
config: true
computer_science: true
hide_from_post: true
tag: ["binary search", "algorithm"]
comments: false
---

# binary search
 - linear searchに比べて計算量がlogで落ちる
   - 1024までの探索は2^10回で済む
 - pure pythonでも実装することができ、シンプルでわかりやすい
 - また、ギリギリ条件が成立する領域の探索にも使うことができる
   - かんたんにも止まらない最小値・最大値を求めるとき、微分することや条件を変えることが求められる
 - ランダウ表記では`O(n)`が`O(log n)`になる

## テンプレート

```python
def is_ok(n):
    return "boolean"

def meguru_bisect(ng, ok):
    while (abs(ok - ng) > 1):
        mid = (ok + ng) // 2
        if is_ok(mid):
            ok = mid
        else:
            ng = mid
    return ok
print(meguru_bisect(0, 10**20))
```
 - bisect_left, bisect_rightにしたいなどニーズに応じで`ng`, `ok`を反転したりする

## ライブラリによる使用例

**cpp**   
```cpp
std:upper_bound(vec.begin(), vec.end(), something_value);
```

```cpp
std:lower_bound(vec.begin(), vec.end(), something_value);
```

**python**  
value以下の最大の要素位置  
```python
bisect.bisect_right(vec, value)
```

value以上の最小の要素位置  
```python
bisect.bisect_left(vec, value)
```

**pythonでの例**  
```python
A = [1, 1.5, 2, 2.5, 3, 3.5, 4, 4.5, 5]
print( bisect.bisect_left(A, 3), A[bisect.bisect_left(A, 3)] ) # 4 3 検索要素以下の値 (>=)

print( bisect.bisect_right(A, 3), A[bisect.bisect_right(A, 3)] ) # 5 3.5 検索要素より最初に大きい値 (<)

print( bisect.bisect(A, 3), A[bisect.bisect(A, 3)] ) # 5 3.5

print( bisect.bisect_left(A, 0.5) ) # 0 1以下の要素であるから

print( bisect.bisect_right(A, 6) ) # 9 満たす要素がないからインデックス以上
```

**pythonでのキー(関数)を与えたレシピ**  
```python
class KeyifyList(object):
    def __init__(self, inner, key):
        self.inner = inner
        self.key = key

    def __len__(self):
        return len(self.inner)

    def __getitem__(self, k):
        return self.key(self.inner[k])


if __name__ == '__main__':
    import bisect
    L = [(0, 0), (1, 5), (2, 10), (3, 15), (4, 20)]
    assert bisect.bisect_left(KeyifyList(L, lambda x: x[0]), 3) == 3
    assert bisect.bisect_left(KeyifyList(L, lambda x: x[1]), 3) == 1
```
 - [参考](https://gist.github.com/ericremoreynolds/2d80300dabc70eebc790)

## pure pythonによる実装例
 - pure pythonによる実装例

```python
# Iterative Binary Search Function
# It returns index of x in given array arr if present,
# else returns -1

def binary_search(arr, x):
    low = 0
    high = len(arr) - 1
    mid = 0
    while low <= high:
        mid = (high + low) // 2
        # If x is greater, ignore left half
        if arr[mid] < x:
            low = mid + 1
        # If x is smaller, ignore right half
        elif arr[mid] > x:
            high = mid - 1
        # means x is present at mid
        else:
            return mid
    # If we reach here, then the element was not present
    return -1

# Test array
arr = [ 2, 3, 4, 10, 40 ]
x = 10
result = binary_search(arr, x)
if result != -1:
    print("Element is present at index", str(result))
else:
    print("Element is not present in array")
```
 - [参考](https://www.geeksforgeeks.org/python-program-for-binary-search/)

  
## 例; なんとかして評価式を作って評価式が成立しているか確認する二分探索

**問題**  
 - [AtCoder Regular Contest 050; B - 花束](https://atcoder.jp/contests/arc050/tasks/arc050_b)  
 - [AtCoder Beginner Contest 192; D - Base n](https://atcoder.jp/contests/abc192/tasks/abc192_d)  
   - [colab](https://colab.research.google.com/drive/1Olg30PbHN4f7eY-LK3CpaVjrmBliiQmP?usp=sharing)

**解説**  
この式は上限が成立する最大値を求めるもの  
`ok`, `ng`構文が使えるので楽に二分探索できる  

```python
R,B=map(int,input().split())
X,Y=map(int,input().split())

def check(n):
    r = R-n
    b = B-n
    if r < 0 or b < 0:
        return False
    if r//(X-1) + b//(Y-1) >= n:
        return True
    else:
        return False


def meguru_bisect(ng, ok):
    while (abs(ok - ng) > 1):
        mid = (ok + ng) // 2
        if check(mid):
            ok = mid
        else:
            ng = mid
    return ok
print(meguru_bisect(ng=10**20, ok=0))
```

## 例; 表題で説明されている指標ではなく、とりうる時間に着目して二分探索する例  

**問題**  
[No.1101 鼻水](https://yukicoder.me/problems/no/1101)

**解答**  
[提出](https://yukicoder.me/submissions/662725)

## 例; 最大値のリストの最小値の最大値を知りたい

**問題**  
`min(max(e0, e1,...), max(f0, f1,...), ...)`を知りたいような場合、機械的な操作が入るので二分探索ができるような気がしないが、実際は各々の構成要素が`k`以上であることを求める二分探索にすることができる  
感覚的には結びつかないので、何らか工夫する必要がある  
 - [ZONeエナジー プログラミングコンテスト “HELLO SPACE”; C - MAD TEAM](https://atcoder.jp/contests/zone2021/editorial/1197)

**解答**  

```python

N = int(input())
A = [tuple(map(int, input().split())) for i in range(N)]
def check(x):
    s = set()
    for a in A:
        s.add(sum(1 << i for i in range(5) if a[i] >= x))
    for x in s:
        for y in s:
            for z in s:
                if x | y | z == 31:
                    return True
    return False
ok = 0
ng = 10**9 + 1
while ng - ok > 1:
    cen = (ok + ng) // 2
    if check(cen):
        ok = cen
    else:
        ng = cen
print(ok)
```

---

## 例; 整数ではない解を持つ最大値を求める -> 微分して初めて負になる点を求める

**問題**  
 - [AtCoder Regular Contest 054; B - ムーアの法則](https://atcoder.jp/contests/arc054/tasks/arc054_b)  

**解説**  
 - 整数ではない二分探索の例  
 - 左から見ていって初めて単調増加でなくなる点 ＝ 微分して初めてマイナスになる点を探す  

**解答1**  

```python
P = float(input())
def f(x):
    return x + P*(2**(-x/1.5))

def check(n):
    d = (10**-9)
    return f(n+d) - f(n) < 0

ok = 0
ng = P
while True:
    mid = (ok + ng) / 2
    if check(mid):
        ok = mid
    else:
        ng = mid
    if ng - ok < 10**-8:
        break
print(f(ok))
```

**解答2**  
 - 微分した式を直接評価する

```python
import math

P = float(input())

def f(x):
    return x + P*(2**(-x/1.5))

def is_ok(x):
    # x + P*(2**(-x/1.5)) を微分すると
    # 1 + P * 2**(-x/1.5) * log 2 * (-1/1.5)
    if 1 + P * 2**(-x/1.5) * math.log(2) * (-1/1.5) > 0:
        return True
    return False

def meguru_bisect(ng, ok):
    while (abs(ok - ng) > 0.000000001):
        mid = (ok + ng) / 2
        if is_ok(mid):
            ok = mid
        else:
            ng = mid
    print(f(ok))
meguru_bisect(0, 10**20)
```

---

## 例; ある値より大きいかつ、ある値より小さいのindexを求める

[AtCoder Beginner Contest 077; C - Snuke Festival](https://atcoder.jp/contests/abc077/tasks/arc084_a)  

bisectのモジュールだけでは`x値`以上のものを検索する関係上、正しい答えが得られない  
そのため二分探索をフルスクラッチする必要がある  

```python
N = int(input())
A = sorted(list(map(int,input().split())))
B = list(map(int,input().split()))
C = sorted(list(map(int,input().split())))

ans = 0
for n in range(N):
    b = B[n]

    l = 0
    r = len(A)
    while l < r:
        mid = (l+r) // 2
        if A[mid] < b:
            l = mid + 1
        else:
            r = mid
    ai = l

    l = 0
    r = len(C)
    while l < r:
        mid = (l+r) // 2
        if b < C[mid]:
            r = mid
        else:
            l = mid + 1
    ci = l
    ans += ai*(N-ci)
print(ans)
```


