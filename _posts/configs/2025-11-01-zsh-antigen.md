---
layout: post
title: "zsh antigen"
date: 2025-10-01
excerpt: "zsh の antigen の基本"
config: true
tag: ["zsh", "antigen", "plugin"]
comments: false
sort_key: "2025-10-01"
update_dates: ["2025-10-01"]
---

# zsh antigen の基本

## 概要
 - 依存が少ない zsh 用プラグインマネージャ

## インストール

```console
$ curl -L git.io/antigen > ~/antigen
```

 - `.zshrc` で `source ~/antigen` を読み込む

## 使い方の最小例

```zsh
# .zshrc の一部
source ~/antigen

# プラグインの読み込み
antigen bundle zsh-users/zsh-autosuggestions

# 設定の適用
antigen apply
```

## プラグインの追加インストール

```zsh
antigen bundle <plugin-name>
```

