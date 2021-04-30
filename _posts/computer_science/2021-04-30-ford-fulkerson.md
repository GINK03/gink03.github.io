---
layout: post
title: "ford fulkerson"
date: 2021-04-28
excerpt: "フォードファルカーソンアルゴリズムについて"
computer_science: true
hide_from_post: true
tag: ["algorithm", "graph", "ford-fulkerson"]
comments: false
---

# フォードファルカーソンアルゴリズムについて
 - グラフの最大流問題を解決するアルゴリズムの一つ
   - もとのグラフと残渣グラフにて、dfsで流れがあるパスを一つ見つける
   - パスの最小の流れの太さをそのパスに当てはめる
   - 残渣グラフにその逆の値を当てはめる
	 - 抵抗する流れを記すため
   - パスが見つからなくなるまで以上を続ける

## pythonでの実装

***例で用いるネットワーク***
<div>
  <img src="https://user-images.githubusercontent.com/4949982/116665592-ec723280-a9d4-11eb-8295-82431f90d9a3.png">
</div>
***例で用いたネットワークの最大の運送量***
<div>
  <img src="https://user-images.githubusercontent.com/4949982/116665580-ea0fd880-a9d4-11eb-8bfe-9e642e851222.png">
</div>

```python
from typing import Optional, Dict, List
from typing import NewType

Matrix = NewType("Matrix", List[List[int]])

def dfs(C, F, s, t) -> Optional[List]:
    stack = [s]
    paths = {s: []}
    if s == t:
        return paths[s]
    while(stack):
        u = stack.pop()
        for v in range(len(C)):
            if(C[u][v]-F[u][v] > 0) and v not in paths:
                paths[v] = paths[u]+[(u, v)]
                print(paths)
                if v == t:
                    return paths[v]
                stack.append(v)
    return None


def max_flow(C, s, t) -> int:
    n = len(C)  # C is the capacity matrix
    # 残渣グラフ
    F: Matrix = [[0] * n for i in range(n)]
    path = dfs(C, F, s, t)
    while path != None:
        flow = min(C[u][v] - F[u][v] for u, v in path)
        for u, v in path:
            F[u][v] += flow
            F[v][u] -= flow
        path = dfs(C, F, s, t)
    return sum(F[s][i] for i in range(n))

C = [[0, 16, 13, 0, 0, 0],
     [0, 0, 10, 12, 0, 0],
     [0, 4, 0, 0, 14, 0],
     [0, 0, 9, 0, 0, 20],
     [0, 0, 0, 7, 0, 4],
     [0, 0, 0, 0, 0, 0]]

source = 0
sink = 5
max_flow_value = max_flow(C, source, sink)
print("Ford-Fulkerson algorithm")
print("max_flow_value is: ", max_flow_value)
```
