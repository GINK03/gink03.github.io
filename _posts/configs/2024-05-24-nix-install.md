---
layout: post
title: "nix install"
date: 2024-05-24
excerpt: "nixコマンドのインストールについて"
tags: ["nix", "nixpkgs", "macos", "linux", "nix", "package manager"]
config: true
comments: false
sort_key: "2024-05-24"
update_dates: ["2024-05-24"]
---

# nixコマンドのインストールについて

## 概要
 - nixは、NixOSのパッケージマネージャ
 - ubuntu, centos, macosなどのOSで利用可能
 - マルチユーザーインストールとシングルユーザーインストールが可能
   - マルチユーザーインストールが推奨

## インストール

**ubuntu/debian**
```console
$ sh <(curl -L https://nixos.org/nix/install) --daemon
```

**macOS**
```console
$ sh <(curl -L https://nixos.org/nix/install)
```

## アンインストール

**nix daemonを停止**
```console
$ sudo systemctl stop nix-daemon.service
$ sudo systemctl disable nix-daemon.socket nix-daemon.service
$ sudo systemctl daemon-reload
```

**ファイルを削除**
```console
$ sudo rm -rf /etc/nix /etc/profile.d/nix.sh /etc/tmpfiles.d/nix-daemon.conf /nix ~root/.nix-channels ~root/.nix-defexpr ~root/.nix-profile
```

**ユーザー・グループを削除**
```console
$ for i in $(seq 1 32); do
  sudo userdel nixbld$i
done
$ sudo groupdel nixbld
```

## 参考
 - [Nix : the package manager - Download](https://nixos.org/download/#nix-install-linux)
 - [Uninstalling Nix - Nix Reference Manual](https://nixos.org/manual/nix/stable/installation/uninstall)
