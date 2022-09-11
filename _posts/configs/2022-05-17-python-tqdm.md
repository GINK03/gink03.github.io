---
layout: post
title: "pythonでのtqdm"
date: "2022-05-17"
excerpt: "pythonでのtqdmの扱い方"
project: false
config: true
tag: ["python", "tqdm"]
comments: false
sort_key: "2022-05-17"
update_dates: ["2022-05-17"]
---

# pythonでのtqdmの扱い方

## 概要
 - プログレスバーの表示を行うツール
 - pandasとの連携もできる

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
   - 環境変数と紐付けて管理すると便利
     - `for x in tqdm(..., disable=os.environ.get("DISABLE_TQDM", False)):`

---

## nextを利用してtqdmのカウンターを回す
 - `tqdm`インスタンスを`iter`でラップすることで、`next`関数を利用してカウンターを回すことができる

```python
counter = iter(tqdm(...))
next(counter) # tqdmがインクリメントされる
```

### 具体例
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

---

## pandasと連携
 - `tqdm.pandas()`を最初に実行する必要がある

### 具体例
```python
import os
from tqdm.auto import tqdm

tqdm.pandas(desc="なにかメッセージ", disable=bool(os.environ.get("DISABLE_TQDM")))
df["any"].progress_apply(func)
```

---

## 参考
 - [github.com/tqdm/tqdm](https://github.com/tqdm/tqdm)
