---
layout: post
title: "gnu screen設定"
date: 2017-04-02
excerpt: "自分向け資料"
config: true
tag: ["gnu screen"]
comments: false
sort_key: "2018-01-19"
update_dates: ["2018-01-19"]
---

# gnu screen

## 概要
 - [/tmux/](/tmux/)より古くからあるterminal multiplexer
 - 最新版をgitから取得してコンパイルしないとtrue colorを扱えない
 - macos版でデタッチ後、リタッチするとパスワードが要求され続けるなど、バグがあるようで基本的にはtmuxを使ったほうが良さそうである

---

## 基本的な使い方

### エスケープキー
 - `Ctrl + a`

### タブを新規作成
 - `Ctrl + a c`

### 次のタブへ
 - `Ctrl + a n`

### 前のタブへ
 - `Ctrl + a p`

### セッションのデタッチ
 - `Ctrl + a Ctrl + d`

### セッションのリタッチ

```console
$ screen -r 
```

### セッション一覧を表示

```console
$ screen -ls
```

---

## 設定ファイル

### 設定ファイルのパス
 - `~.screenrc`に記す

### 設定ファイルの具体例
```config
hardstatus alwayslastline "[%02c] %`%-w%{=b bw}%n %t%{-}%+w"
autodetach on
vbell off
# escape ^Zz
bind s split
bind o only
bind r remove
bind f focus
```

---

## 参考
 - [5.1 Default Key Bindings/gnu](https://www.gnu.org/software/screen/manual/html_node/Default-Key-Bindings.html)
 - [screen コンパイル](https://gist.github.com/tomohiro/403431/0d3397a4da58c8eb9476f1e3f00cd5a57eabd2d7)
 - [GNU Screen/Archlinux Wiki](https://wiki.archlinux.org/title/GNU_Screen)
