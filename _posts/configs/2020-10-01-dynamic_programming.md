---
layout: post
title:  "dynamic_programming"
date:   2020-10-01
excerpt: "dynamic_programming"
project: false
config: true
tag: []
comments: false
---

# dynamic programming

## 概要
 - 配る方、もらう方の２つがある
 - とても多いたどり着くための方法があるとき、使う
 - ２つの変数で構築できる(optional?)

## e.g. https://atcoder.jp/contests/abc179/tasks/abc179_d

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


## e.g. AtCoder Typical DP A
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

