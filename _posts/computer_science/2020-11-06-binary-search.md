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
 - pure pythonでも実装することができ、シンプルでわかりやすい
 - ランダウ表記では`O(n)`が`O(log n)`になる

## ライブラリによる使用例

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

## pure pythonによる実装例
 - pure pythonによる実装例

```python
# Iterative Binary Search Function
# It returns index of x in given array arr if present,
# else returns -1

def binary_search(arr, x):
    low = 0
    high = len(arr) - 1
    mid = 0
    while low <= high:
        mid = (high + low) // 2
        # If x is greater, ignore left half
        if arr[mid] < x:
            low = mid + 1
        # If x is smaller, ignore right half
        elif arr[mid] > x:
            high = mid - 1
        # means x is present at mid
        else:
            return mid
    # If we reach here, then the element was not present
    return -1

# Test array
arr = [ 2, 3, 4, 10, 40 ]
x = 10
result = binary_search(arr, x)
if result != -1:
    print("Element is present at index", str(result))
else:
    print("Element is not present in array")
```
 - [参考](https://www.geeksforgeeks.org/python-program-for-binary-search/)
