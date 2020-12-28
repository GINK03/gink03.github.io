---
layout: post
title: "transport a lot of files"
date: 2020-12-29
excerpt: ""
tags: ["ssh"]
comments: false
---

**NOTE**  
 - この`post`は[/ssh](/ssh)からリンクされるのが望ましい

# sshで大量のデータを送信する
とにかく大量のデータを扱っている際、sshなどでデータを転送しようにもファイルが多すぎて話にならないなどがある。  
sshで幾つかやり方がある  

tarで圧縮しつつ転送などが良いらしい。  

## pipeで転送する
早い
```console
tar czf - <files or dir> | ssh user@host "cd /{$PATH} && tar xvzf -"
```

## ssh + tar 
```console
tar cf - something_huge_dir/ | ssh {$UNAME}@121.2.69.245 "bzip2 -9 - > ${HOME}/archive.tar.bz2"
```
これで送れる。

なお、ローカルで圧縮するには、zipより、
```console
tar cfj archive.tar.bz2 something_huge_dir/ 
```
が便利

## 解凍
```console
tar -xjf archive.tar.bz
```
