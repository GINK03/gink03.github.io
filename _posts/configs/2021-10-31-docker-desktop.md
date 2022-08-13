---
layout: post
title: "docker-desktop"
date: "2021-10-31"
excerpt: "docker-desktopの使い方"
project: false
config: true
tag: ["docker", "windows", "osx", "docker-desktop"]
comments: false
sort_key: "2022-02-08"
update_dates: ["2022-02-08","2021-10-31"]
---

# docker-desktopの使い方

## 概要
 - osx, windowsで利用できるdokcerの環境と管理ツールを提供する
 - linux版のdockerと異なり仮想マシンとして動作する

## インストール

**windows**
```console
> choco install docker-desktop
```

**macos**  
```console
$ brew install docker # `docker`の指定でdocker-desktopが導入される
```

## 具体的な使い方

### windows環境でwslと統合する
docker-desktopの設定より、wsl統合を選択できる  
選択するとwsl内部でdockerの利用が可能になる

### windows環境でdocker-desktopが更新できない
 - `com.dokcer.service`が終了できなくなっていることが原因であるケース
   - 管理者で`Stop-Service com.docer.service`で解決できる
