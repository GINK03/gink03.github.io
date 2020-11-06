---
layout: post
title:  "binary_search"
date:   2020-11-06
excerpt: "binary_search"
project: false
config: true
tag: ["binary search"]
comments: false
---

# binary search
cppとpythonは厳密に一致していない

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


