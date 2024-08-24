---
layout: post
title: "python str"
date: "2022-07-17"
excerpt: "python strの使い方"
config: true
tag: ["python", "str"]
comments: false
sort_key: "2022-07-17"
update_dates: ["2022-07-17"]
---

# python strの使い方

## 概要
 - `split`で文字列を分割する
   - `split(" ", 1)`で最初の1つだけ分割する
 - strのインデックスはutf8の一文字単位で区切られている
   - slicingの末尾がよくわからなくなりがち(end-1の位置までsliceされる)

## 具体例

**splitの使い方**
```python
assert "a b c d".split(" ", 1) == ["a", "b c d"]
```

**sliceの使い方**
```python
s = "あいうえお"
# indexの最初はその文字
# 末尾はindex-1の文字まで
assert s[1:3] == "いう"

# すべてのsubstringの切り取り
# jのindexの最大値を+1する必要ある
for i in range(len(s)):
    for j in range(i+1, len(s)+1):
        print(s[i:j])
"""
あ
あい
あいう
あいうえ
あいうえお
い
いう
いうえ
いうえお
う
うえ
うえお
え
えお
お
"""

# bfsですべてのパターンで切り取る
from collections import deque
que = deque([(0, "")])
res = []
vis = set()
while que:
    i, buff = que.popleft()
    if len(buff) - buff.count("/") == len(s):
        res.append(buff)

    for j in range(i+1, len(s)+1):
        que.append( (j, buff + "/" + s[i:j]) )
    vis.add(i)
print(*res, sep="\n")
"""
/あいうえお
/あ/いうえお
/あい/うえお
/あいう/えお
/あいうえ/お
/あ/い/うえお
/あ/いう/えお
/あ/いうえ/お
/あい/う/えお
/あい/うえ/お
/あいう/え/お
/あ/い/う/えお
/あ/い/うえ/お
/あ/いう/え/お
/あい/う/え/お
/あ/い/う/え/お
"""
```

## 参考
 - [Word Break/Submission Detail](https://leetcode.com/submissions/detail/748979649/)
