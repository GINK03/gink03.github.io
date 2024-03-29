---
layout: post
title: "smartmontools"
date: 2021-03-07
excerpt: "smartmontoolsについて"
tags: ["smart", "smartmontools", "smartctl"]
config: true
comments: false
sort_key: "2022-01-19"
update_dates: ["2022-01-19","2021-03-08","2021-03-08"]
---

# smartmontoolsについて

## インストール

***ubuntu***
```console
$ sudo apt install smartmontools
```

***osx***
```console
$ brew install smartmontools
```

## 引数
 - `--scan`
   - すべてのディスクを表示
 - `-H /dev/<sdx>`
   - `sdx`のヘルスチェック

## 具体例

### すべての情報を表示する

***ubuntu***
```console
$ sudo smartctl -a /dev/sda
```
 - `/dev/sda`は適宜変更する

***osx***
```console
$ smartctl -a /dev/disk0
```
 - `/dev/disk0`は適宜変更する

## TBWとは
 - TeraByteWrite: 書き込み可能テラバイトのこと

## Total_LBAs_Writtenから書き込んだデータ量を計算する
 - LBAの単位はsector sizeに一致する
   - 多くが512byte

***計算の例***
```python
total_lbas = 1353413225 # 具体的に観測できた値
write_gb = total_lbas * 512 / (1024**3)
print(write_gb) # 645gb書き込んだことがわかる
```

## 余談: windowsでの確認
 - [crystal disk info](https://crystalmark.info/en/software/crystaldiskinfo/)を使うとすぐわかる
