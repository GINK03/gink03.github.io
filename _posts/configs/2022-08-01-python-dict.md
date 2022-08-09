---
layout: post
title: "python dict"
date: 2022-08-01
excerpt: "python dictの使い方"
tags: ["python", "dict"]
config: true
comments: false
sort_key: "2022-08-01"
update_dates: ["2022-08-01"]
---

# python dictの使い方

## 概要
 - pythno3からdictの順序が保存されるようになった
   - 二分木での実装に変更された？
 - 順序があるdictは`popitem`関数があり、`LIFO`である
 - `setdefault`関数があり、キーがない場合に入れる値である
   - 応用すると、トライ木が簡潔に実装できる
 - `get`は第2引数に、キーが存在しない場合、返す値を設定できる
   - 環境変数が存在しない場合にデフォルト値を返したい時に便利
     - e.g. `os.environ.get("DISABLE_TQDM", False)`

## 具体例

```python
d = dict(k2=1, k1=2)

assert(d == dict(k1=2, k2=1))
assert(d.popitem() == ("k1", 2))

d["k1"] = 2
assert(d.setdefault("k3", dict()) == {})
assert(d.pop("k1") == 2)
```

## トライ木の実装

```python
WORD_KEY = '$'

trie = {}
for word in words:
    node = trie
    for char in word:
        node = node.setdefault(char, {})
    # mark the existence of a word in trie node
    node[WORD_KEY] = word
```

## 参考
 - [212. Word Search II/LeetCode](https://leetcode.com/problems/word-search-ii/)
