---
layout: post
title:  "gnu screen設定"
date:   2017-04-02
excerpt: "自分向け資料"
project: false
config: true
tag:
- gnu screen
comments: false
---

# gnu screen
.screenrcに記す

```sh
hardstatus alwayslastline "[%02c] %`%-w%{=b bw}%n %t%{-}%+w"
autodetach on
vbell off
escape ^Zz
bind s split
bind o only
bind r remove
bind f focus
```
