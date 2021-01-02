---
layout: post
title:  "rain cloud plot"
date:   2021-01-02
excerpt: "rain cloud plot"
project: false
config: true
tag: ["可視化", "matplot", "seaborn", "rain cloud plot"]
comments: false
---

# rain cloud plot

## 概要
 - matplotをラップした可視化ライブラリ
   1. box plotとバイオリンプロットを合成したもの
   2. 分布の形とboxの性質の2つがわかって丁度いい

## install
```console
$ pip install ptitprince
```

## 使い方

```python
import pandas as pd
import numpy as np
import matplotlib.pyplot as plt
import seaborn as sns
import ptitprince

fig, ax = plt.subplots(figsize=(12, 10))
ptitprince.RainCloud(data=df, ax=ax, orient='v')
plt.xticks(rotation=90)

fig.tight_layout()
```

[*詳細はgistのjupyter linkへ*](https://gist.github.com/GINK03/0ee7e93ba25788850a1d102dc24f6dc2#file-untitled-ipynb)

<div>
  <img src="https://user-images.githubusercontent.com/4949982/103451799-9da8da80-4d0b-11eb-97eb-5654334aa727.png">
</div>
