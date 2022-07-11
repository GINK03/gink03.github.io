---
layout: post
title: "posix pathのパース"
date: 2021-03-26
excerpt: "stackを用いたposix pathのパース"
computer_science: true
tag: ["algorithm", "data structure", "データ構造", "stack"]
comments: false
sort_key: "2022-01-19"
update_dates: ["2022-01-19","2021-12-29"]
---

# stackを用いたposix pathのパース

## 概要
 - posixでのpathの操作には`/./`, `/..`, `./relative`などの方言がある
   - これらの値に応じて要素を削除したり追加したりする
 - 要素の追加と削除がある操作ではstack(or que)を用いてシミュレーションするとやりやすい
 - `決定性有限オートマトン`とも組み合わせしやすい

## 具体例

```python
from collections import deque
def solve(path):
    ents = deque(path.split("/"))
    stack = deque([])

    while ents:
        e = ents.popleft()
        if e in {"", "."}:
            continue
        if e in {".."}:
            if stack:
                stack.pop()
        else:
            stack.append(e)

    if path[0] == "/":
        return "/" + "/".join(stack)
    else:
        return "/".join(stack)

assert(solve("/home/") == "/home")
assert(solve("/home//foo/") == "/home/foo")
assert(solve("/../") == "/")
assert(solve("a/./b") == "a/b" )
assert(solve("/a/./b/../../c/") == "/c")
assert(solve("/a/../../b/../c//.//") == "/c")
assert(solve("/a//b////c/d//././/..") == "/a/b/c")
```

## 参考
 - [71. Simplify Path/LeetCode](https://leetcode.com/problems/simplify-path/)

