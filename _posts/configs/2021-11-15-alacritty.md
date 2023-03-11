---
layout: post
title: "alacritty"
date: "2021-11-15"
excerpt: "alacrittyの使い方"
project: false
config: true
tag: ["terminal emulator", "rust", "alacritty"]
comments: false
sort_key: "2021-11-15"
update_dates: ["2021-11-15"]
---

# alacrittyの使い方

## 概要
 - rust製の自称最も早いエミュレータ
 - 速度を追求するため、tab機能など他のターミナルエミュレータにある機能がない  
   - tabは正式にサポートしないとgithubのissueで作者が答えたことがあった

## インストール

**macOS**  
```console
$ brew install alacritty
```

## 設定

`$HOME/.alacritty.yml`のファイルが最初に起動すると自動生成されるのでこれを編集する  

**フォントのサイズとファミリーを設定する**  

```yaml
font:
  size: 12.0 # デフォルトより大きい値を指定する
  normal:
    family: SFMono Nerd Font
  bold:
    family: SFMono Nerd Font
  italic:
    family: SFMono Nerd Font
  bold_italic:
    family: SFMono Nerd Font
```

---

## トラブルシューティング

### 日本語のinplace-inputができない
 - 原因
   - [そのうち解決されるはずのバグ](https://github.com/alacritty/alacritty/issues/1101)
 - 対応
   - 2023-03ではinplace-inputの問題は生じていない
