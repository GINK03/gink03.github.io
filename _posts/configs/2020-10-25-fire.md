---
layout: post
title: "fire"
date: 2020-10-25
excerpt: "fire"
project: false
config: true
tag: ["python3", "cli", "args"]
comments: false
sort_key: "2021-08-05"
update_dates: ["2021-08-05","2021-08-04","2020-10-25","2020-10-25"]
---

# fire

## 概要
 - argparseを用いなくても簡単に実装できる引数ハンドリング & 関数呼び出しライブラリ
 - cli libray
 - 簡単でわかりやすい

## インストール

```console
$ python3 -m pip install fire
```

## 具体例
 - 関数を具体的に指定してそれ以外呼べないようにする

```python
import fire

def hello(name="World"):
  return "Hello %s!" % name

if __name__ == '__main__':
  fire.Fire(hello)
```

**使用例**  

```console
$ python hello.py  # Hello World!
$ python hello.py --name=David  # Hello David!
```

## 具体例2
 - すべての関数を公開して呼べるようにする

```python
import fire

def hello_world():
    print("hello world")

def add(x, y):
  return x + y

def multiply(x, y):
  return x * y

if __name__ == '__main__':
    fire.Fire()
```

**使用例**  

```console
$ python3 hello.py hello_world # hello wold
$ python3 hello.py add 10 20 # 30
```

## 具体例3
 - 公開する関数を限定する
 - 関数に引数を与えることもできる

```python
import fire

def hello(w):
    print("hello " + w)

if __name__ == '__main__':
    fire.Fire({"hello": hello})
```

**使用例**  

```console
$ python3 hello.py hello world # hello world
```
