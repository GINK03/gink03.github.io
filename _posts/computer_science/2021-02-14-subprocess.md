---
layout: post
title: "subprocessについて"
date: 2021-02-14
excerpt: "subprocessについて"
computer_science: true
hide_from_post: true
tag: ["subprocess"]
comments: false
---

# subprocessについて

## 概要
 - 標準出力に入出力するインターフェース  
 - linuxでは`fd(file descriptor)`を用いてやり取りする

## pythonでの例

```python
from subprocess import PIPE
from subprocess import Popen


with Popen(["cat"], stdin=PIPE, stdout=PIPE) as proc:
    proc.stdin.write(b"something input\n")
    proc.stdin.close()
    print(proc.stdout.read())
```
*output*
```console
b'something input\n'
```
 - pythonでは高機能なsubprocessのラッパーである`Popen`が用意されている
 - `cat`を起動して、`something input`のバイナリ列を書き込む
 - `cat`から出力された内容を読み込む
 - 他の機能は[公式を参照](https://docs.python.org/3/library/subprocess.html#subprocess.Popen)
