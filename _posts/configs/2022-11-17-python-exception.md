---
layout: post
title: "python exception"
date: "2022-11-17"
excerpt: "python exceptionの使い方"
config: true
tag: ["python", "exception"]
comments: false
sort_key: "2022-11-17"
update_dates: ["2022-11-17"]
---

# python exceptionの使い方

## 概要
 - 基底クラス`Exception`があり、これを継承することで独自の例外を作ることができる
 - 評価順は通常のオブジェクト指向と同じ

## 具体例

```python
class SalaryNotInRangeError(Exception):
    """Exception raised for errors in the input salary.
    Attributes:
        salary -- input salary which caused the error
        message -- explanation of the error
    """

    def __init__(self, salary, message="Salary is not in (5000, 15000) range"):
        self.salary = salary
        self.message = message
        super().__init__(self.message)

    def __str__(self):
        return f'{self.salary} -> {self.message}'


salary = int(input("Enter salary amount: "))
if not 5000 < salary < 15000:
    raise SalaryNotInRangeError(salary=salary, message="Salary is not in (5000, 15000) range")

"""
Enter salary amount: 2000
Traceback (most recent call last):
  File "~/.tmp/tmp.py", line 20, in <module>
    raise SalaryNotInRangeError(salary)
__main__.SalaryNotInRangeError: 2000 -> Salary is not in (5000, 15000) range
"""
```

---

## 参考
 - [Python Custom Exceptions](https://www.programiz.com/python-programming/user-defined-exception)
