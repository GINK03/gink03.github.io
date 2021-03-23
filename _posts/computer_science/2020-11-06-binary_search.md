---
layout: post
title: "binary search"
date: 2020-11-06
excerpt: "binary searchについて"
project: false
config: true
computer_science: true
hide_from_post: true
tag: ["binary search", "algorithm"]
comments: false
---

# binary search
 - linear searchに比べて計算量がlogで落ちる
   - 1024までの探索は2^10回で済む

## 二分探索で`O(N)`を`O(log(N))`に変換する

**cpp**   
上界   
```cpp
std:upper_bound(vec.begin(), vec.end(), something_value);
```

下界  
```cpp
std:lower_bound(vec.begin(), vec.end(), something_value);
```

**python**  
上界   
```python
bisect.bisect_right(vec, something_value)
```

下界  
```python
bisect.bisect_left(vec, something_value)
```

**pythonでの例**  
```python
>>> import bisect
>>> bisect.bisect_right([1,3,3,4,5], 2)
1
>>> bisect.bisect_right([1,3,3,4,5], 1)
1
>>> bisect.bisect_right([1,3,3,4,5], 3)
3
>>> bisect.bisect_left([1,3,3,4,5], 3)
1
>>> bisect.bisect_left([1,3,3,4,5], 4)
3
```

**pythonでのキー(関数)を与えたレシピ**  
```python
class KeyifyList(object):
    def __init__(self, inner, key):
        self.inner = inner
        self.key = key

    def __len__(self):
        return len(self.inner)

    def __getitem__(self, k):
        return self.key(self.inner[k])


if __name__ == '__main__':
    import bisect
    L = [(0, 0), (1, 5), (2, 10), (3, 15), (4, 20)]
    assert bisect.bisect_left(KeyifyList(L, lambda x: x[0]), 3) == 3
    assert bisect.bisect_left(KeyifyList(L, lambda x: x[1]), 3) == 1
```
 - [参考](https://gist.github.com/ericremoreynolds/2d80300dabc70eebc790)
