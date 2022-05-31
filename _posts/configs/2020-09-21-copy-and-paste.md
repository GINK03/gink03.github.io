---
layout: post
title: "コピーとペースト"
date: 2020-09-21
excerpt: "各OSでコピーとペーストを便利に行う"
config: true
tag: ["osx", "linux", "tmux"]
sort_key: "2020-09-21"
update_dates: ["2022-05-31", "2020-09-21","2020-09-21"]
comments: false
---

# 各OSでコピーとペーストを便利に行う

## MacOSX

### pbpasteを使う場合
 - osxにはデフォルトでpbcopy, pbpasteが公開されている

#### 具体例

**copy**  
```console
$ echo "foobar" | pbcopy
```
 - `pbcopy`された内容はosxのクリップボードにも反映される

**paste**  
```console
$ pbpaste
foobar
```

## Linux
### xclipを使用する場合
#### install

```console
$ sudo apt-get install xclip
```

#### 具体例
**copy**  
```console
$ echo "a" | xclip -selection clipboard
```
**paste**  
```console
$ xclip -selection clipboard -o
```

---

## tmuxを使用する場合

**copy**  
```console
$ echo "a" | tmux load-buffer -b a -
```
or 
```console
$ tmux set-buffer -b a "a"
```
NOTE: -bオプションでバッファネームを付けないと、paneをまたいで利用できない

**show**  
```console
$ tmux show-buffer -b a
```

**paste**
```console
$ tmux paste-buffer -b a
```
NOTE: prefixモードに入ったあとには `paste-buffer -b a` で利用できる(vim等に直接入力できる)
