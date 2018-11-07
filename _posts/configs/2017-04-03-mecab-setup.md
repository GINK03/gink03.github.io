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

### AnacondaDockerベースから構築する
ポータビリティと再現性があるのでオススメ
```Dockerfile
FROM continuumio/anaconda3:latest
COPY . /app
RUN pip install -r ./app/requirements.txt
RUN apt update
RUN apt install build-essential mecab libmecab-dev mecab-ipadic -y
RUN pip install mecab-python3
RUN apt install git make sudo -y
RUN cd tmp; git clone --depth 1 https://github.com/neologd/mecab-ipadic-neologd.git; 
RUN cd /tmp/mecab-ipadic-neologd; ./bin/install-mecab-ipadic-neologd -n -y
RUN cd /app; cat mecabrc > /etc/mecabrc
CMD python
```
