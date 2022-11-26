---
layout: post
title: "python one-liner"
date: "2022-11-26"
excerpt: "python one-linerの使い方"
config: true
tag: ["python", "one-liner"]
comments: false
sort_key: "2022-11-26"
update_dates: ["2022-11-26"]
---

# python one-linerの使い方

## 概要
 - shellのコマンドラインの中で複雑なことをやりたいときに便利
 - perlのように本当に一行で書くのは難しく、ヒアドキュメントのような方法で書くことになる

## 具体例(word countの例)

```python
$ echo "the day is sunny the the
the sunny is is
" | python3 -c '
import sys
from collections import Counter
a = [x.split() for x in sys.stdin.read().split("\n")]
t = []
for x in a:
    for y in x:
        t.append(y)
for x, y in sorted(Counter(t).items(), key=lambda x:-x[1]):
    print(x, y)
'
```

---

## 参考
 - [Executing multi-line statements in the one-line command-line/StackOverflow](https://stackoverflow.com/questions/2043453/executing-multi-line-statements-in-the-one-line-command-line)
