---
layout: post
title: "decimal to any base"
date: 2021-05-09
excerpt: "decimal to any base(10進数を任意のN進数に変換)について"
computer_science: true
hide_from_post: true
tag: ["algorithm", "math", "integer"]
comments: false
---

# decimal to any base(10進数を任意のN進数に変換)について

## python

**10進数を任意のN進数のリストに変換する**
```python
def decimal_to_base(x: int, base: int) -> list:
    if x//base:
        return decimal_to_base(x//base, base) + [x%base]
    return [x%base]
 
x = decimal_to_base(10, 2)
assert x == [1, 0, 1, 0]
x = decimal_to_base(10, 8)
assert x == [1, 2]
x = decimal_to_base(10, 16)
assert x == [10]
```
 - [colab](https://colab.research.google.com/drive/1tWmirKG0H-eb6ZgM2fZRvXj_bKz6fSuT?usp=sharing)

  
**10進数を任意のN進数の記号のリストに変換する**

```python
# 文字の対応表
m = {}
for i in range(100):
    if i >= 10:
        m[i] = chr(ord('A')+i-10)
    else:
        m[i] = str(i)
        
def decimal_to_base_str(x: int, base: int) -> list:
    to_str = lambda a: m[a]
    if x//base:
        return decimal_to_base_str(x//base, base) + [to_str(x%base)]
    return [to_str(x%base)]
 
x = decimal_to_base_str(111111, 16)
assert x == ['1', 'B', '2', '0', '7']
```
