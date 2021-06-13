---
layout: post
title: "dynamic programming"
date: 2021-03-26
excerpt: "動的計画法について"
project: false
config: true
tag: ["algorithm", "dynamic programming"]
comments: false
---

# 動的計画法について

## 概要
 - 具体例を例示しつつ説明する
 - 多くの解決法として、listやvectorを作成し、inf等を入力し、前の入力から今の入力の最小や最大を取得する
 - **適応例**
   - 全組み合わせせの探索としても使る
	 - その場合二次元マトリックスを作成する
   - 手順を踏んで計算すると`O(n^3)`や`O(n^2)`の計算になってしまうような場合
	 - [小さいサンプルから一般化すると動的計画法で得られるように導くことができる](#例; まともに計算するとO(n^3)になるのをO(n)に変換する)

---

## 例; 繰り返しのないナップサック問題
**問題**  
[DPL_1_B](https://judge.u-aizu.ac.jp/onlinejudge/description.jsp?id=DPL_1_B)

**解答**  
```python
N, W = map(int, input().split())

VW = []
for n in range(N):
    v, w = map(int, input().split())
    VW.append((v, w))

dp = [[0]*(W+10) for _ in range(N+1)]
for i, (v, w) in enumerate(VW):
    for j in range(0, W+10):
        if j >= w:
            dp[i+1][j] = max(dp[i][j], dp[i][j-w] + v)
        else:
            dp[i+1][j] = dp[i][j]
print(dp[-1][W])
```

---

## 例; 繰り返しのあるナップサック問題
**問題**  
[DPL_1_A](https://judge.u-aizu.ac.jp/onlinejudge/description.jsp?id=DPL_1_A)

**解答**  
```python
N,M=map(int,input().split())
A=list(map(int,input().split()))

dp=[float('inf')]*(N+10)
dp[0] = 0
for a in A:
    for j in range(len(dp)):
        if j >= a:
            dp[j] = min(dp[j], dp[j-a] + 1)
print(dp[N])
```

---

## 例; もっとも基礎的な部分和問題

**問題**  
 - [Typical DP Contest; A - コンテスト](https://atcoder.jp/contests/tdpc/tasks/tdpc_contest)  

**解答1**  
```python
N=int(input())
A=list(map(int,input().split()))

POINTS_MAX = 100*100 + 10
dp = [[0]*POINTS_MAX for _ in range(len(A)+1)]
dp[0][0] = 1
for i in range(len(A)):
    for j in range(POINTS_MAX):
        dp[i+1][j] |= dp[i][j] # 上の状態と同じ
        if j >= A[i]: # itemを選択できるならば
            dp[i+1][j] |= dp[i][j-A[i]] # 前のアイテムが有るならばtrueになる(アイテムがtrueをフォワードできる)
print(sum(dp[len(A)]))
```

**解答2**  
```python
N=int(input())
*P,=map(int,input().split())

dp = [[0]*(sum(P) + 10) for _ in range(N+1)]
dp[0][0] = 1
for i in range(N):
    for j in range(sum(P)+10):
        dp[i+1][j] = dp[i][j]
        if j - P[i] >= 0:
            dp[i+1][j] += dp[i][j-P[i]]
print(len(list(filter(lambda x:x>0,dp[-1]))))
```


---

## 例; まともに計算するとO(n^3)になるのをO(n)に変換する

**問題**  
 - [京セラプログラミングコンテスト2021; E - Patisserie ABC 2](https://atcoder.jp/contests/abc200/tasks/abc200_e)

**解説**  
小さいサンプルで試すと、インプットが大きいほうが長い配列になることが確認できる  
配列の作成され方にも法則性がありそうである  
法則性は動的計画法で作成可能である(非常に定式化が難しい例)  
 - [公式解説](https://atcoder.jp/contests/abc200/editorial/1247)

**解答**  
 - [提出](https://atcoder.jp/contests/abc200/submissions/22454970)
 - [colab](https://colab.research.google.com/drive/1S1IJ7uUOhJtByHrQzlNjEziYbTEc3sMS?usp=sharing)  

---

## 例; 中間的な最適解を与えながら計算する

**問題**  
 - [AtCoder Beginner Contest 197; E - Traveler](https://atcoder.jp/contests/abc197/tasks/abc197_e)  

**解説**  
中間的な最適解が色を選ぶたびに得られる  
この中間的な最適解を次のステップの最適解を構築する  

**解答**  
 - [colab](https://colab.research.google.com/drive/10qgyGooCuoGIgd6db2bn_AyKFy8fHyl1?usp=sharing)

---

## 例; Money Change Again

**問題**  
<div>
  <img src="https://user-images.githubusercontent.com/4949982/112585301-e53b9000-8e3c-11eb-9cd1-017295283630.png">
</div>
 
**解説**  
 - `math.inf`を使用して初期化する
 - 前の入力から最もコイン数が小さいものを選択する

**解答**  
```python
import math

money = int(input())
denominations = [1, 3, 4]
minCoins = [0] + [math.inf]*money
for i in range(1, money+1):
    for j in denominations:
        if i>=j:
            coins = minCoins[i-j]+1
            if coins < minCoins[i]:
                minCoins[i] = coins
print(minCoins[money])
```

---

## 例; Primitive Calculator

**問題**  
<div>
  <img src="https://user-images.githubusercontent.com/4949982/112586241-c3dba380-8e3e-11eb-9104-a5b767204c76.png">
</div>
 
**解説**  
 - `math.inf`を使用して初期化する
 - 前の状態が特定の数字で割り切れることで場合分けを行う
 - `n`数分のリストを作成して初期化する

**解答**  

```python
import math
n = int(input())
# number of operations required for getting 0, 1, 2,.. , n
num_operations = [0, 0] + [math.inf]*(n-1)
for i in range(2, n+1):
    temp1, temp2, temp3 = [math.inf]*3
    temp1 = num_operations[i-1] + 1 
    if i%2 == 0: temp2 = num_operations[i//2] + 1
    if i%3 == 0: temp3 = num_operations[i//3] + 1
    min_ops = min(temp1, temp2, temp3)
    num_operations[i] = min_ops
print(num_operations[n])
# Backtracking the numbers leading to n
nums = [n]
while n!=1:
    if n%3 ==0 and num_operations[n]-1 == num_operations[n//3]:
        nums += [n//3]
        n = n//3
    elif n%2 ==0 and num_operations[n]-1 == num_operations[n//2]:
        nums += [n//2]
        n = n//2
    else:
        nums +=[n-1]
        n = n - 1
print(' '.join([str(i) for i in nums][::-1]))
```

---

## 例; 区間で定義された特定の移動方があるとき、目的地につくまで移動法は何通りあるか

**問題**  
 - [AtCoder Beginner Contest 179; D - Leaping Tak](https://atcoder.jp/contests/abc179/tasks/abc179_d)  

**解説**  
最初を`1`としたテーブルを作成し、そこから何通りあるかを考える  

**回答**  

```python
N,K = map(int,input().split())
section = []
dp = [0]*(N+1)
S = [0]*(N+1)
MOD = 998244353
for _ in range(K):
    L,R = map(int,input().split())
    section.append((L,R))
section.sort()
dp[1] = 1
S[1] = 1

for i in range(2,N+1):
    for j in range(K):
        li = i - section[j][1]
        ri = i - section[j][0]
        if ri <= 0:
            continue
        li = max(li,1)
        dp[i] += (S[ri] - S[li-1]) % MOD
    
    S[i] = (dp[i] + S[i-1]) % MOD
 
print(dp[N] % MOD)
```

---

## 例;  AtCoder Typical DP A
 - [link](https://atcoder.jp/contests/tdpc/tasks/tdpc_contest)

縦積みしたvectorをイメージして上から次の数を考慮するしない、次で考慮したらどの値(indexで表現している)になるかをdpで計算している  

```cpp
#include <bits/stdc++.h>
using namespace std;
 
int main(){
    int N;
    cin >> N;
    vector<int> p(N+1);
    p[0] = 0;
    for(int i = 1; i <= N; ++i) cin >> p[i];
    int W = 0;
    for(int i = 0; i <= N; ++i) W += p[i];
    vector<vector<bool>> dp(N+1,vector<bool>(W+1,false));
    for(int i = 0; i <= N; ++i) {
      for(int j = 0; j <= W; ++j) {
        if(i > 0) {
          if(dp[i-1][j] == true) {
            dp[i][j] = true;
            if(j+p[i] <= W) dp[i][p[i]+j] = true;
          }
        }
        if(p[i] == j) dp[i][j] = true;
      }
    }
 
    int count = 0;
    for(int j = 0; j <= W; ++j) {
      if(dp[N][j] == true){
        count++;
      }
    }
    cout << count << endl;
}
```

