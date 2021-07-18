---
layout: post
title: "benchmarks"
date: 2021-07-18
excerpt: "benchmarksについて"
tags: ["benchmarks"]
config: true
comments: false
---

# benchmarks

## SSDの寿命のベンチマーク
 - 大量のデータをSSDに書き込んで寿命を迎えさせる
 - 単位時間にどれくらい書き込めるか、等のベンチマークも兼ねられる
 - pythonのコードで実現できる

```python
import os
from pathlib import Path
import random
import itertools
from tqdm import tqdm
from concurrent.futures import ProcessPoolExecutor as PPE
import timeit

def run(arg=0):
    start_time = timeit.default_timer()

    fp = open(f"tmp_{arg}.txt", "w")
    try:
        a = f"{random.random():0.09f}"
        for cnt in tqdm(itertools.count(1), disable=True if arg != 0 else False):
            if cnt % 10**5 == 0:
                a = f"{random.random():0.09f}"
            fp.write(a)
    except Exception as exc:
        Path(f"tmp_{arg}.txt").unlink()
    finally:
        pass
    elapsed = timeit.default_timer() - start_time
    print(f'{elapsed:0.06f} seconds')

while True:
    num = 4
    with PPE(max_workers=num) as exe:
        exe.map(run, list(range(num)))
```
