---
layout: post
title: "[specific]Adding Exits to a Maze"
date: 2021-04-18
excerpt: "[specific]Adding Exits to a Maze"
computer_science: true
hide_from_post: true
specific: true
tag: ["algorithm", "graph", "data structure", "データ構造"]
comments: false
---

# [specific]Adding Exits to a Maze
 - [dfs](/dfs)で解くことが可能な例

## 問題

<div>
  <img src="https://user-images.githubusercontent.com/4949982/115143457-5d832300-a082-11eb-9b67-70ef11068579.png">
</div>

**回答**

```python
#Uses python3
import sys

def number_of_components(adj):
    result = 0
    #write your code here
    visited = [0] * len(adj)
    for i in range(len(adj)):
        if not visited[i]:
            explore(adj, i, visited)
            result += 1
    return result

def explore(adj, x, visited):
    visited[x] = 1
    for i in range(len(adj[x])):
        if not visited[adj[x][i]]:
            explore(adj, adj[x][i], visited)

if __name__ == '__main__':
    n, m = map(int, input().split())
    adj = [[] for _ in range(n)]
    for i in range(m):
        a, b = map(int, input().split())
        # adjacency list		
        adj[a - 1].append(b - 1)
        adj[b - 1].append(a - 1)
    print(number_of_components(adj))
```
