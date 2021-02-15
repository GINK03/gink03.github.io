---
layout: post
title: "kernel density estimation"
date: 2021-02-11
excerpt: "カーネル密度推定の概要"
kaggle: true
hide_from_post: true
tag: ["kernel density estimation", "statistics", "ノンパラメトリック"]
comments: false
---

# カーネル密度推定の概要

## 概要
確率密度関数を推定するノンパラメトリックの一つ  

ヒストグラムのサンプルが十分に取れたとき、頻度で押し切ったカーネル密度推定量と解釈可能  

$$
\hat{f}= \frac{1}{nh} \sum K(\frac{x - x_i}{h}) \\
K(x) = \frac{1}{\sqrt{2\pi}}e^{-x^2/2}
$$

これの視覚的理解は、正規分布のある幅に区切られた重ね合わせで表現するというものである  

つまりあるサンプルがあるとき、そこに一つの正規分布を構築する。これを観測できたサンプルに対して適応するとなめらかな曲線の山ができる  

## 参考
 - [カーネル密度推定](https://ja.wikipedia.org/wiki/%E3%82%AB%E3%83%BC%E3%83%8D%E3%83%AB%E5%AF%86%E5%BA%A6%E6%8E%A8%E5%AE%9A)
