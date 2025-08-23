---
layout: post
title: "matplotlib/seaborn font"
date: 2024-05-31
excerpt: "matplotlib/seaborn のフォント設定メモ"
tag: ["seaborn", "python", "matplotlib", "可視化"]
kaggle: true
comments: false
sort_key: "2024-05-31"
update_dates: ["2024-05-31"]
---

# matplotlib/seaborn font

## seaborn特有の問題点
 - フォントを設定したあとも
   - `sns.set()`, `sns.set_theme()` でフォントが上書きされることがある
 - 回避策
   - `sns.set()` / `sns.set_theme()` の呼び出し後に `plt.rcParams['font.family']` を再設定する
   - または `sns.set_theme(font='Noto Sans CJK JP')` のようにフォントを明示する

## Ubuntuで日本語フォントを使う

**フォントのインストール & キャッシュクリア**

```console
$ sudo apt update && sudo apt install -y fonts-noto-cjk
$ rm -rf ~/.cache/matplotlib 
```

```python
import matplotlib.pyplot as plt
import matplotlib
import seaborn as sns
print(f"rcParams = {matplotlib.rcParams['font.family']}")

# 日本語フォントを直接指定
plt.rcParams['font.family'] = 'Noto Sans CJK JP'
# マイナス記号の文字化け対策
plt.rcParams['axes.unicode_minus'] = False

sns.barplot(x=["日本語"], y=[1])
plt.title("日本語タイトル")
plt.show()
```

## Windowsで日本語フォントを使う

```python
import matplotlib.pyplot as plt
import seaborn as sns
import os

if os.name == 'nt':
    sns.set(font='Yu Gothic')
```
