---
layout: post
title: "alacritty"
date: "2021-11-15"
excerpt: "alacrittyの使い方"
project: false
config: true
tag: ["terminal emulator", "rust"]
comments: false
---

# alacrittyの使い方

## 概要
 - rust製の自称最も早いエミュレータ
 - 速度を追求するため、tab機能など他のターミナルエミュレータにある機能がない  

## インストール

**osx**  
```console
$ brew install alacritty
```

## 設定

`$HOME/.alacritty.yml`のファイルが最初に起動すると自動生成されるのでこれを編集する  

**フォントサイズを大きくする**  

```yaml
font:
  size: 15.0 # デフォルトより大きい値を指定する
```

## 既知の問題

### 日本語のinplace-inputができない
 - [そのうち解決されるとのこと](https://github.com/alacritty/alacritty/issues/1101)
