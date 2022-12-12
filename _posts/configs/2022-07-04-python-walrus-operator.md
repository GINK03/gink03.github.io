---
layout: post
title: "python walrus operator(assignment expressions)"
date: "2022-07-04"
excerpt: "python walrus operator(assignment expressions)の使い方"
project: false
config: true
tag: ["python", "assignment expressions", "walrus operator", "ウォルラス演算子"]
comments: false
sort_key: "2022-07-04"
update_dates: ["2022-07-04"]
---

# python walrus operator(assignment expressions)の使い方

## 概要
 - python 3.8から導入された`:=`という演算子
   - ウォルラス演算子と呼ばれる
 - 変数に束縛を行いつつ、値を返すということができる

## 具体例

### if文で値を評価しつつ、変数に代入する

```python
if match := re.match(pattern, text):
    print(match)
```
 - `match`という変数をifの上で作る必要がない

### リスト内包表記で値を変更しながら、変更した値を得る

```python
nums = [0, 1, 2, 3, 4]

total = 0
sum_list = [total := total + i for i in nums]

assert(sum_list == [0, 1, 3, 6, 10])
```

### iteratorから値を取り出す

```python
while line := getstream():
    print(line)
```
 - 内部がyieldなどで実装されているiteratorなどの時

```python
def test(s):
    if (c := s[0]) != "あ":
        assert c != "あ"
    else:
        assert c == "あ"

test("あいうえお")
test("かきくけこ")
```
 - 変数を束縛した上でその内容を具体的に評価する場合

## 参考
 - [:= （ウォルラス演算子）の使い方](https://www.lifewithpython.com/2019/10/python-walrus-operator-assignment-expression.html)
 - [What's New In Python 3.8](https://docs.python.org/ja/3/whatsnew/3.8.html)
