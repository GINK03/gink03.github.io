---
layout: post
title: "hashlib"
date: "2022-01-14"
excerpt: "hashlibの使い方"
project: false
config: true
tag: ["python", "hashlib"]
comments: false
sort_key: "2022-01-14"
update_dates: ["2022-01-14"]
---

# hashlibの使い方

## 概要
 - pythonの標準以外のhash関数
 - python標準のhash関数はセキュリティ上の課題によりシード値が毎回ランダム化するので一定の値を使いたい場合はhashlibを使う

## サポートするアルゴリズム

```python
import hashlib
print(hashlib.algorithms_available)

# {'md5', 'sha3_256', 'sha3_384', 'sha1', 'blake2s', 'sha224', 'sha256', 'sha3_224', 'sha3_512', 'blake2b', 'shake_256', 'sha384', 'sha512', 'shake_128'}
```

## 各アルゴリズムのダイジェストサイズ

```python
from hashlib import sha1, md5, sha224, sha256, sha512, sha3_512, pbkdf2_hmac
for algorithm in [md5, sha1, sha224, sha256, sha512, sha3_512]:
    m = algorithm()
    m.update(b"Nobody inspects")
    m.update(b" the spammish repetition")
    # print(m.digest())
    print(algorithm)
    print(m.digest_size)
```
 - `md5`
   - 16バイト
 - `sha1`
   - 20バイト
 - `sha224`
   - 28バイト
 - `sha512`
   - 32バイト
 - `sha3_512`
   - 64バイト
 - `pbkdf2_hmac`
   - 64バイト

## google colab
 - [colab](https://colab.research.google.com/drive/1IpHzMY9QrlYuRnSFWKpKoVu9APqSry96?usp=sharing)

## 参考
 - [hashlib — Secure hashes and message digests](https://docs.python.org/3/library/hashlib.html#module-hashlib)
