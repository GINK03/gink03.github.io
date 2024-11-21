---
layout: post
title: "plotly treemap"
date: 2024-11-21
excerpt: "plotly treemap"
kaggle: true
hide_from_post: true
tag: ["可視化", "visualizations", "python", "plotly"]
comments: false
sort_key: "2024-11-21"
update_dates: ["2024-11-21"]
---

# plotly treemap

## 概要
 - 株価の可視化などに使用されるtreemap

## サンプルコード
 - 人口と平均寿命のデータを使用してtreemapを作成する

```python
import plotly.io as pio
pio.renderers.default = 'iframe'  # または 'jupyterlab', 'notebook', 'browser' に変更

import plotly.express as px
import numpy as np

df = px.data.gapminder().query("year == 2007")
fig = px.treemap(df, path=[px.Constant("world"), 'continent', 'country'], 
                  values='pop',
                  color='lifeExp', 
                  hover_data=['iso_alpha'],
                  color_continuous_scale='RdBu',
                  color_continuous_midpoint=np.average(df['lifeExp'], weights=df['pop']))
fig.update_layout(margin = dict(t=5, l=5, r=5, b=5))
fig.show()
```
