---
layout: post
title: "ubuntu mainline kernels"
date: 2023-09-27
excerpt: "ubuntuのmainline kernelsの使い方"
tags: ["ubuntu", "linux", "mainline kernels", "software"]
config: true
comments: false
sort_key: "2023-09-27"
update_dates: ["2023-09-27"]
---

# ubuntuのmainline kernelsの使い方

## 概要
 - [Ubuntu Mainline Kernel PPA](https://kernel.ubuntu.com/~kernel-ppa/mainline/)から最新のカーネルをdebパッケージでインストールできる
 - 上記サイトをラップしている[Mainline Kernels](https://github.com/bkw777/mainline)というツールがある
 - 特定のCPUやハードウェアに対応したカーネルをインストールすることができる
   - Ubuntuのデフォルトインストーラで入るカーネルで一部のハードウェアが動作しない事がある

## Mainline Kernelsのインストール

```console
$ sudo add-apt-repository ppa:cappelikan/ppa
```

## Mainline Kernelsの使い方

### カーネルの最新バージョンのインストール

```console
$ sudo mainline install-latest
```

### インストール可能なカーネルの一覧を表示

```console
$ mainline list
```

### 特定のバージョンのカーネルをインストール

```console
$ sudo mainline install 5.10.0
```

## 参考
 - [Ubuntu Mainline Kernel PPA](https://kernel.ubuntu.com/~kernel-ppa/mainline/)
 - [Mainline Kernels](https://github.com/bkw777/mainline)
