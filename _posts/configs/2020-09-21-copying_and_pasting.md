---
layout: post
title:  "copying_and_pasting"
date:   2020-09-21
excerpt: "copying_and_pasting"
project: false
config: true
tag: []
comments: false
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
$ echo "a" | tmux load-buffer -
```
or 
```console
$ tmux set-buffer "a"
```

**show**  
```console
$ tmux show-buffer
```

**paste**
```console
$ tmux paste-buffer
```

