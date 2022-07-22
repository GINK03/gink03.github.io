---
layout: post
title: "make linux fast again"
date: "2022-07-22"
excerpt: "make linux fast againの説明と使い方"
config: true
tag: ["security", "linux", "performance"]
comments: false
sort_key: "2022-07-22"
update_dates: ["2022-07-22"]
---

# make linux fast againの説明と使い方

## 概要
 - CPUの脆弱性が発見されるとLinuxはそれに対応したアップデートを行う
 - セキュリティの向上とパフォーマンスはトレードオフで、セキュリティを上げるとパフォーマンスは下がる
 - Linuxのカーネルパラメータに脆弱性に対応する機能を読み込まないように設定するとパフォーマンスが向上する

## make linux fast againの使い方
 - 脆弱性を無視するようにするLinuxのカーネルパラメータ

**2022年の内容**

```config
noibrs noibpb nopti nospectre_v2 nospectre_v1 l1tf=off nospec_store_bypass_disable no_stf_barrier mds=off tsx=on tsx_async_abort=off mitigations=off
```

### `/etc/default/grub`を編集する

```grub
...
GRUB_CMDLINE_LINUX_DEFAULT="quiet splash noibrs noibpb nopti nospectre_v2 nospectre_v1 l1tf=off nospec_store_bypass_disable no_stf_barrier mds=off tsx=on tsx_async_abort=off mitigations=off"
...
```
 - `GRUB_CMDLINE_LINUX_DEFAULT`への設定がカーネルパラメータになる

**編集後**
```console
$ sudo update-grub
$ sudo reboot
```

### パフォーマンスの比較
 - Ryzen 3700Xでの実験
 - unixbenchでの比較を行った

**カーネルパラメータ設定前**
```config
# シングルスレッド
System Benchmarks Index Score                                        1521.8
# マルチスレッド
System Benchmarks Index Score                                        7227.6
```

**カーネルパラメータ設定後**
```config
# シングルスレッド
System Benchmarks Index Score                                        1698.2
# マルチスレッド
System Benchmarks Index Score                                        7604.6
```

## まとめ
 - シングルスレッドで`11.5%`の性能の向上
 - マルチスレッドで`5.2%`の性能の向上
