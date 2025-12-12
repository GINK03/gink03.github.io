---
layout: post
title: "unixbench"
date: 2021-09-05
excerpt: "unixbenchの使い方"
tag: ["unixbench"]
config: true
comments: false
sort_key: "2022-05-03"
update_dates: ["2022-05-03","2022-01-19","2021-10-25","2021-09-07","2021-09-05"]
---

# unixbenchの使い方

## 概要
 - UnixやLinux向けのベンチマークソフト
 - 実行には`perl`, `gcc`, `g++`が必要
 - 一回の実行に時間がかかるためサンプルサイズを指定する`-i`オプションを付けるとよい
 - macOSで使用するにはgccとclangの互換性問題を避けるためpatchを当てる

## インストール

**ubuntu**  

```console
$ wget https://storage.googleapis.com/google-code-archive-downloads/v2/code.google.com/byte-unixbench/UnixBench5.1.3.tgz
$ tar zxvf UnixBench5.1.3.tgz
$ cd UnixBench
```

**macOS**  

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

**コア数を指定して実行**  

```console
$ ./Run -i 1 -c <コア数>
```

## サンプル結果

**ubuntu, ryzen 3700x**  

```console
# シングルコア
System Benchmarks Index Score                                        2036.4
# マルチコア
System Benchmarks Index Score                                        8266.5
```

**ubuntu, ryzen 5700G**

```console
# シングルコア
System Benchmarks Index Score                                        2786.6
# マルチコア
System Benchmarks Index Score                                       16117.7
```

**macOS, m1**

```console
# シングルコア
System Benchmarks Index Score                                        1545.4
# マルチコア
System Benchmarks Index Score                                        2485.2
```

**MS-R1 CP8180**

```console
# シングルコア
System Benchmarks Index Score                                         938.8
# マルチコア
System Benchmarks Index Score                                        4016.5
```

**windows 11, wsl2, ubuntu, ryzen 3800x**

```console
# シングルコア
System Benchmarks Index Score                                        1221.6
# マルチコア
System Benchmarks Index Score                                        5989.3
```

**ubuntu, Oracle Cloud Always Free(Arm 4CPU, 24GB)**  
```console
# シングルコア
System Benchmarks Index Score                                        1539.9
# マルチコア
System Benchmarks Index Score                                        3434.3
```
