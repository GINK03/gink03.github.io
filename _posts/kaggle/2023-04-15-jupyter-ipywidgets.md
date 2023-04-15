---
layout: post
title: "jupyter ipywidgets"
date: 2023-04-15
excerpt: "jupyter ipywidgetsの使い方"
tags: ["jupyter", "jupyter lab", "ipywidgets"]
kaggle: true
comments: false
sort_key: "2023-04-15"
update_dates: ["2023-04-15"]
---

# jupyter ipywidgetsの使い方

## 概要 
 - jupyterでGUI機能を追加するもの
 - 最終的な提供物に対してipywidgetsを設定してわかりやすく提供することができる

## インストール

```console
$ python3 -m pip install ipywidgets
```

## 具体例

### スライダー

```python
import ipywidgets as widgets
from IPython.display import display

slider = widgets.FloatSlider(
    value=0.5,
    min=0,
    max=1,
    step=0.01,
    description='パラメータ:',
    readout_format='.2f',
)
display(slider)
print(slider.value)
```

### ドロップダウン

```python
dropdown = widgets.Dropdown(
    options=['オプション1', 'オプション2', 'オプション3'],
    value='オプション1',
    description='選択:',
)
display(dropdown)
```

### チェックボックス

```python
checkbox = widgets.Checkbox(
    value=False,
    description='チェックボックス',
)
display(checkbox)
```

### レンジスライダー

```python
range_slider = widgets.FloatRangeSlider(
    value=[0, 1],
    min=0,
    max=1,
    step=0.01,
    description='範囲:',
    readout_format='.2f',
)
display(range_slider)
```

### 二つの変数を操作してすぐ結果を得る

```python
def multiply(x, y):
    return x * y

widgets.interact(
    multiply,
    x=widgets.FloatSlider(min=-10, max=10, step=0.1, value=0, description="x"),
    y=widgets.FloatSlider(min=-10, max=10, step=0.1, value=0, description="y")
);
```
