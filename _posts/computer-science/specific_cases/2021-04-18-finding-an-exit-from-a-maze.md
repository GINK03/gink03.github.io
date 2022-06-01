---
layout: post
title: "[specific]Finding an Exit from a Maze"
date: 2021-04-18
excerpt: "[specific]Finding an Exit from a Maze"
computer_science: true
hide_from_post: true
specific: true
tag: ["algorithm", "graph", "data structure", "データ構造"]
comments: false
---

# [specific]Finding an Exit from a Maze
 - [dfs](/dfs)で解くことが可能な例

## 問題

<div>
  <img src="https://user-images.githubusercontent.com/4949982/115137053-a923d580-a05e-11eb-95a9-9336764679c9.png">
  <img src="https://user-images.githubusercontent.com/4949982/115137055-ac1ec600-a05e-11eb-8ca8-a7cd6fb88826.png">
</div>

**回答**

```python
#Uses python3
import sys


def reach(adj, x, y):
    #write your code here
    visited = [0] * len(adj)
    return explore(adj, x, y, visited)
	
def explore(adj, x, y, visited):
    if (x == y):
        return 1
    visited[x] = 1
    for i in range(len(adj[x])):
        if (not visited[adj[x][i]]):
            if(explore(adj, adj[x][i], y, visited)):
                return 1
    return 0

if __name__ == '__main__':
    n, m = map(int, input().split())
    adj = [[] for _ in range(n)]
    for i in range(m):
        a, b = map(int, input().split())
        # adjacency list		
        adj[a - 1].append(b - 1)
        adj[b - 1].append(a - 1)
    x, y = map(int, input().split())
    print(reach(adj, x-1, y-1))
```
