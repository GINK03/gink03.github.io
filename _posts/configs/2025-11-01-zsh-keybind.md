---
layout: post
title: "zsh キーバインド"
date: 2025-11-01
excerpt: "zsh のキーバインドの基本"
config: true
tag: ["zsh", "keybind"]
comments: false
sort_key: "2025-11-01"
update_dates: ["2025-11-01"]
---

# zsh のキーバインド

## よく使う設定
 - `"^[^?"`: backward-kill-word
   - `alt + delete`でカーソルの後ろのワードを削除(argumentの一つを消す)

## 設定の確認

```console
$ bindkey
```

## 特定の機能をバインド

```zsh
# Alt+wで次の単語へ
bindkey "∑" forward-word
# Alt+bで前の単語へ
bindkey "∫" backward-word
# Alt+→で次の単語へ
bindkey "^[[1;3C" forward-word
# Alt+←で次の単語へ
bindkey "^[[1;3D" backward-word
# Alt+aで autosuggest-accept
bindkey "å" autosuggest-accept
```

 - `alt + arrow`で前か次の単語へ移動できる

