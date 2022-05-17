---
layout: post
title: "pythonでのtqdm"
date: "2022-05-17"
excerpt: "pythonでのtqdmの扱い方"
project: false
config: true
tag: ["python", "tqdm"]
comments: false
---

# pythonでのtqdmの扱い方

## 概要
 - プログレスバーの表示を行うツール

## インストール

```python
$ python3 -m pip install tqdm
```

## インターフェース
 - `total`
   - 全体の大きさがわからない場合に引数で値を入れるとその大きさと仮定してプログレスバーを標示する
 - `desc`
   - プログレスバーに標示するヒントの文字列
 - `ncols`
   - 幅の大きさ
 - `position`
   - 下から何行目に標示するか
 - `disable`
   - `True`を入れると表示されなくなる

## nextを利用してtqdmのカウンターを回す
 - `tqdm`インスタンスを`iter`でラップすることで、`next`関数を利用してカウンターを回すことができる

```python
counter = iter(tqdm(...))
next(counter) # tqdmがインクリメントされる
```

## 具体例
 - `tqdm.auto`経由でimportすることでjupyterでもterminalでも表示できる

```python
from tqdm.auto import tqdm
import itertools
import random
import time

counter = iter(tqdm(itertools.count(0), desc="sampling...", position=1, total=500, ncols=100))
for i in tqdm(range(1000), desc="working...", position=0, ncols=100):
    time.sleep(0.005)
    if random.random() <= 0.5:
        next(counter)
```

<div>
  <img src="https://user-images.githubusercontent.com/4949982/168730212-5e10dcd2-59af-48aa-9732-856cc4a7942e.png">
</div>

## 参考
 - [github.com/tqdm/tqdm](https://github.com/tqdm/tqdm)
