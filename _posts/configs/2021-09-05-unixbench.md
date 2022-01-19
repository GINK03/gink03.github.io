---
layout: post
title: "unixbench"
date: 2021-09-05
excerpt: "unixbenchの使い方"
tags: ["unixbench"]
config: true
comments: false
---

# unixbenchの使い方

## 概要
 - unix, linuxのベンチマークソフト
 - 実行するために`perl`, `gcc`, `g++`が必要な模様
 - 一回の実行にそれなりに時間がかかるので一回あたりのサンプルサイズを指定する`-i`オプションを付けたほうがいい
 - osxで使用するにはpatchを当てる必要がある(gccとclangで互換性がないため)

## インストール

**ubuntu**  

```console
$ wget https://storage.googleapis.com/google-code-archive-downloads/v2/code.google.com/byte-unixbench/UnixBench5.1.3.tgz
$ tar zxvf UnixBench5.1.3.tgz
$ cd UnixBench
```

**osx**  

```console
$ wget https://storage.googleapis.com/google-code-archive-downloads/v2/code.google.com/byte-unixbench/UnixBench5.1.3.tgz
$ tar zxvf UnixBench5.1.3.tgz
$ cd UnixBench
$ git clone https://gist.github.com/11033924.git
$ patch -p1 < ./11033924/UnixBench5.1.3.mavericks.patch
```

## 実行

```console
$ ./Run -i 1
```

## サンプル結果

**ubuntu, ryzen 3700x**  

```console
# シングルコア
System Benchmarks Index Score                                        2036.4
# マルチコア
System Benchmarks Index Score                                        8266.5
```

**osx, m1**

```console
# シングルコア
System Benchmarks Index Score                                        1545.4
# マルチコア
System Benchmarks Index Score                                        2485.2
```

**debian, qemu vm on m1**

```console
System Benchmarks Index Score                                        2584.1
```

**vmware, debian, ryzen 3800x**  

```console
System Benchmarks Index Score                                         816.6
System Benchmarks Index Score                                        4249.2
```

**windows 11, wsl2, ubuntu, ryzen 3800x**

```console
System Benchmarks Index Score                                        1221.6
System Benchmarks Index Score                                        5989.3
```
