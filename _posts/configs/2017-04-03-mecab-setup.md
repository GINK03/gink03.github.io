---
layout: post
title:  "mecab設定"
date:   2017-04-02
excerpt: "自分向け資料"
project: false
config: true
tag:
- tmux
comments: false
---

## Ubuntuのインストール
```sh
sudo apt install mecab libmecab-dev mecab-ipadic
sudo apt install mecab-ipadic-utf8
sudo apt install python-mecab
```

### python3 binding
```sh
sudo pip3 install mecab-python3
```

### neologdインストール
```sh
$ git clone --depth 1 https://github.com/neologd/mecab-ipadic-neologd.git
$ ./bin/install-mecab-ipadic-neologd -n
# vim /etc/mecabrc
dicdir = /usr/lib/mecab/dic/mecab-ipadic-neologd

dicdir = /usr/lib/x86_64-linux-gnu/mecab/dic/mecab-ipadic-neologd/ # 17.04
```
