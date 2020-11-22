---
layout: post
title:  "GOOGLE_APPLICATION_CREDENTIALS"
date:   2020-11-21
excerpt: "GOOGLE_APPLICATION_CREDENTIALS"
project: false
config: true
tag: ["GOOGLE_APPLICATION_CREDENTIALS"]
comments: false
---

# GOOGLE_APPLICATION_CREDENTIALS

**概要の理解**  

`GOOGLE_APPLICATION_CREDENTIALS`とは`GCPのサービスアカウントのキー`のことである  

`サービスアカウントのキー`は、`Service Accounts`のページの`操作`の`鍵を作成`から生成が可能である  

## `.bashrc`, `.zshrc`に環境変数を通す

仮に、`~/.var/My Project 54730-b57fa0611de1.json`が自分の`サービスアカウントの鍵`で有る際  

`export GOOGLE_APPLICATION_CREDENTIALS=$HOME/.var/"My Project 54730-b57fa0611de1.json"`  

のようになる。

