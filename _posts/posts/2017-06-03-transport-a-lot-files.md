---
layout: post
title: "TransporfAlotOfFiles"
date: 2017-06-03
excerpt: ""
tags: [ssh]
comments: false
---

# sshで大量のデータを送信する
とにかく大量のデータを扱っている際、sshなどでデータを転送しようにもファイルが多すぎて話にならないなどがある。  
sshで幾つかやり方があるので、参考にする。

tarで圧縮しつつ転送などが良いらしい。

## pipeで転送する
早い
```console
tar czf - <files or dir> | ssh user@host "cd /{$PATH} && tar xvzf -"
```

## ssh + tar 
```console
tar cf - PixivImageScraper/ | ssh {$UNAME}@121.2.69.245 "bzip2 -9 - > ${HOME}/archive.tar.bz2"
```
これで送れる。

なお、ローカルで圧縮するには、zipより、
```console
tar cfj archive.tar.bz2 PixivImageScraper/ 
```
これが便利

## 解凍
```console
tar -xjf archive.tar.bz
```
