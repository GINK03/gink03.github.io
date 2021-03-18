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


