---
layout: post
title: "google colab form"
date: 2023-09-01
excerpt: "google colabのformの使い方"
tags: ["jupyter", "google colab", "colab"]
kaggle: true
comments: false
sort_key: "2023-09-01"
update_dates: ["2023-09-01"]
---

# google colabのformの使い方

## formで変数を変更する(スライダーやドロップリストを表示する)
 - 概要
   - `#@param ~`という記述を追加することで変数をGUIで操作できる
 - ドロップリスト
   - `foo = "a" #@param ["a", "b", "c"] {type: "raw"}`
 - スライダー
   - `bar = 10 #@param {type:"slider", min:0, max:1000, step:100}`

<div>
  <img src="https://f004.backblazeb2.com/file/gimpeik/Images/Screenshot+2023-03-05+at+16.55.13.png">
</div>

## コードセルにタイトルの設定
 - コードセルの先頭に以下を記述
   - `# @title あいうえお`

## コードを隠す
 - `セルの右側のクリック` -> `フォーム` -> `コードを隠す`

## 参考
 - [Forms/Google Colab](https://colab.research.google.com/notebooks/forms.ipynb)
