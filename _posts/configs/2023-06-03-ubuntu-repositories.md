---
layout: post
title: "ubuntu repositories"
date: 2023-06-03
excerpt: "ubuntuのレポジトリについて"
tags: ["ubuntu", "linux", "repositories"]
config: true
comments: false
sort_key: "2023-06-03"
update_dates: ["2023-06-03"]
---

# ubuntuのレポジトリについて

## 概要
 - ubuntuのソフトウェアや更新のバイナリはレポジトリに管理されている
 - レポジトリのURLは`/etc/apt/sources.list`に平文で記述されている
 - サードパーティのレポジトリは`apt-add-repository`で追加できる

## レポジトリのURLを変更する
 - どこのサーバを参照するかでダウンロード速度が大きく異なる
   - `jp.archive.ubuntu.com`
     - 遅い
   - `archive.ubuntu.com`
     - 時間帯によっては遅い
   - `ftp.udx.icscoe.jp/Linux`
     - 早い
     - 秋葉原のUDXにサーバが有るらしい
 - レポジトリの回線の太さは以下のリンクの表に記されている
   - [Official Archive Mirrors for Ubuntu](https://launchpad.net/ubuntu/+archivemirrors)
 - `security.ubuntu.com`は変更してはだめ
   - ミラーへの反映は行われるが時間差があるため、ubuntuのセキュリティチームが変更を推奨していない

### 変更例; `aruchive.ubuntu.com`を`ftp.udx.icscoe.jp/Linux`に変える
 - vim
   - `/etc/apt/sources.list`を開く
   - `:s/archive.ubuntu.com/ftp.udx.icscoe.jp\/Linux/g`
 - sed
   - 秋葉原のUDXのサーバに切り替え
     - `sudo sed -i.org -r 's@http://(jp\.)?archive\.ubuntu\.com/ubuntu/?@https://ftp.udx.icscoe.jp/Linux/ubuntu/@g' /etc/apt/sources.list`
   - 秋葉原のUDXのサーバから元のarchive.ubuntu.comサーバに戻す
     - `sudo sed -i.udx -r 's@https://ftp\.udx\.icscoe\.jp/Linux/ubuntu/?@http://archive.ubuntu.com/ubuntu@g' /etc/apt/sources.list`

## サードパーティのレポジトリを追加・削除する

**追加**
```console
$ sudo apt-add-repository ppa:example/ppa
```

**削除**
```console
$ sudo apt-add-repository --remove ppa:example/ppa
```

## トラブルシューティング
 - `do-release-upgrade -d`できない
   - 対応
     - UDXのレポジトリから元のレポジトリに戻すことで`do-release-upgrade`で可能

## 参考
 - [Ubuntu aptが遅かったので jp.archive.ubuntu.com を変更](https://kuni92.net/2022/10/ubuntu-apt-jparchiveubuntucom.html)
 - [Ubuntuのapt mirrorの設定って結局どうすればいいの？](https://zenn.dev/ciffelia/articles/c394962a8f188a)
 - [security.ubuntu.comはそのままで](https://jyn.jp/what-is-security-ubuntu-com/)
