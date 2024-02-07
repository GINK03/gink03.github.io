---
layout: post
title: "debianのapt sources"
date: 2024-02-07
excerpt: "debianのapt sourcesについて"
tags: ["debian", "linux", "apt"]
config: true
comments: false
sort_key: "2024-02-07"
update_dates: ["2020-02-07"]
---

# debianのapt sourcesについて

## 概要
 - debianではデフォルトではaptのレポジトリの設定が`main`のみになっている
 - ソフトウェアのライセンスに応じて `main`, `contrib`, `non-free`, `non-free-firmware` がある
   - `main` - フリーなソフトウェア
   - `contrib` - フリーなソフトウェアであるが、非フリーなソフトウェアに依存している
   - `non-free` - 非フリーなソフトウェア
   - `non-free-firmware` - 非フリーなファームウェア(ドライバ等)
 - ライセンス情報は任意の順序で記述することができる

## 設定例

```console
$ cat /etc/apt/sources.list
deb http://deb.debian.org/debian/ bookworm main non-free-firmware contrib non-free
deb-src http://deb.debian.org/debian/ bookworm main non-free-firmware contrib non-free

deb http://security.debian.org/debian-security bookworm-security main non-free-firmware contrib non-free
deb-src http://security.debian.org/debian-security bookworm-security main non-free-firmware contrib non-free

# bookworm-updates, to get updates before a point release is made; contrib non-free
# see https://www.debian.org/doc/manuals/debian-reference/ch02.en.html#_updates_and_backports contrib non-free
deb http://deb.debian.org/debian/ bookworm-updates main non-free-firmware contrib non-free
deb-src http://deb.debian.org/debian/ bookworm-updates main non-free-firmware contrib non-free

deb http://deb.debian.org/debian bookworm-backports main non-free-firmware contrib non-free
deb-src http://deb.debian.org/debian bookworm-backports main non-free-firmware contrib non-free
```
