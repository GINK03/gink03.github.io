---
layout: post
title: "python abc"
date: 2023-01-14
excerpt: "pythonのabc(Abstract Base Classes)の使い方"
tags: ["python", "python3", "abc", "abstract base classes"]
config: true
comments: false
sort_key: "2023-01-14"
update_dates: ["2023-01-14"]
---

# pythonのabc(Abstract Base Classes)の使い方

## 概要
 - JavaやC++でよくあるデザインパターンの一つで抽象クラスを作成し、継承して具体化する
 - pyrightのようなlinterも抽象クラスであれば引数の実装が無くても大丈夫

## 具体例

```python
from abc import ABC

class C(ABC):
    @abstractmethod
    def my_method(self):
        ...
```

---

## 参考
 - [abc — Abstract Base Classes/docs.python.org](https://docs.python.org/3/library/abc.html)
