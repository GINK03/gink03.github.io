---
layout: post
title:  "copying_and_pasting"
date:   2020-09-21
excerpt: "copying_and_pasting"
project: false
config: true
tag: []
comments: false
sort_key: "2020-09-21"
update_dates: ["2020-09-21","2020-09-21"]
---
# copying and pasting

## MacOSX

### install

```console
$ brew install pbpaste
```

### examples

**copy**  
```console
$ echo "foobar" | bpcopy
```

**paste**  
```console
$ bppaste
foobar
```

## Linux

### install

```console
$ sudo apt-get install xclip
```

### examples

**copy**  
```console
$ echo "a" | xclip -selection clipboard
```

**paste**  
```console
$ xclip -selection clipboard -o
```

## tmux

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

