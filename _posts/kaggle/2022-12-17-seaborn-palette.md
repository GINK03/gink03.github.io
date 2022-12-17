---
layout: post
title: "seaborn palette"
date: 2022-12-17
excerpt: "seaborn palettの使い方"
tags: ["seaborn", "python", "matplotlib", "可視化"]
kaggle: true
comments: false
sort_key: "2022-12-17"
update_dates: ["2022-12-17"]
---

# seaborn paletteの使い方

## 概要
 - `sns.set_palette関数`で設定できるとされているが反映されないこともある
 - `sns.barplot(x, y, platte=pallet)`などplot関数の引数で個別に色を設定できる
 - seabornで最初から定義されているパレット
   - `deep`, `muted`, `bright`, `pastel`, `dark`, `colorblind`

## jupyter上でパレットの確認

```python
palette = sns.color_palette("Paired")
sns.palplot(palette)
```

<div>
  <img src="https://f004.backblazeb2.com/file/gimpeik/Images/Screenshot+2022-12-17+at+15.24.40.png">
</div>

## ユーザでパレットを定義する

### RGBを繰り返す

```python
palette = sns.color_palette(palette=['r', 'g', 'b'], n_colors=3)
sns.palplot(palette)
```

<div>
  <img src="https://f004.backblazeb2.com/file/gimpeik/Images/Screenshot+2022-12-17+at+15.24.45.png">
</div>

### grayの単色

```python
my_palette = sns.color_palette(palette=['gray'], n_colors=1)
sns.palplot(my_palette)
```

<div>
  <img src="https://f004.backblazeb2.com/file/gimpeik/Images/Screenshot+2022-12-17+at+15.24.49.png">
</div>

---

## 参考
 - [seaborn.color_palette/pydata.org](https://seaborn.pydata.org/generated/seaborn.color_palette.html)
 - [Deep Dive into Seaborn: Color Palettes/Medium](https://medium.com/analytics-vidhya/deep-dive-into-seaborn-palettes-7b5fae5a258e)
