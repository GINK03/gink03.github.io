---
layout: post
title: "python match case"
date: "2022-07-04"
excerpt: "python match caseの使い方"
project: false
config: true
tag: ["python", "match case"]
comments: false
sort_key: "2022-07-04"
update_dates: ["2022-07-04"]
---

# python match caseの使い方

## 概要
 - python3の3.10以上から使える構文
   - vimなどのシンタックスハイライトや構文解析器が対応していないことがある
 - if文を書くと大変なので、C++のswtich文の様に書ける方法
 - 値を変数にキャプチャすることもできる

## 具体例

```python
def check(point):
    match point:
        case (0, 0):
            print("Origin")
        case (0, y):
            print(f"Y={y}")
        case (x, 0):
            print(f"X={x}")
        case ((10, 20) | (20, 10)):
            print(f"orでのマッチ")
        case (x, y):
            print(f"X={x}, Y={y}")
        case _:
            raise ValueError("Not a point")

if __name__ == "__main__":
    check((0, 0)) # Origin
    check((0, 100)) # Y=100
    check((100, 0)) # X=100
    check(("a", "b")) # X=a, Y=b
    check((10, 20)) # orでのマッチ
    check((20, 10)) # orでのマッチ
    check((10, 10)) # X=a, Y=b
    check(("a", "b", "c")) # 例外
```

## 参考
 - [PEP 622 – Structural Pattern Matching](https://peps.python.org/pep-0622/)
