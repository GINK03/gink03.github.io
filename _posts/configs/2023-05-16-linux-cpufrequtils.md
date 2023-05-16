---
layout: post
title: "linux cpufrequtils"
date: 2023-05-16
excerpt: "linuxのcpufrequtilsについて"
config: true
tag: ["linux", "cpufrequtils"]
comments: false
sort_key: "2023-05-16"
update_dates: ["2023-05-16"]
---

# linuxのcpufrequtilsについて

## 概要
 - linuxのコマンドでCPUの周波数を設定できるツール
 - CPUのブースト機能が有効になっているとうるさかったり電気代が高くなったりする問題に対してキャップをかけることができる

## インストール

```console
$ sudo apt install cpufrequtils
```

## `cpufreq-set`でCPUの周波数を設定する

**上限値の設定**
```console
$ sudo cpufreq-set -c $cpu_number --max $frequency
```
 - `$cpu_number`: CPUの番号
 - `$frequency`: kHzで設定する周波数
   - `2000000`で2GHz

## すべてのCPUのコアの周波数を設定する

```sh
#!/bin/zsh

# コマンドライン引数が指定されていない場合はエラーメッセージを表示して終了
if [ -z "$1" ]; then
    echo "Usage: $0 frequency_in_khz"
    exit 1
fi

# コマンドライン引数から設定したい周波数をkHz単位で指定
frequency=$1

# 各CPUコアに対してループを行い、最大周波数を設定
for cpu_path in /sys/devices/system/cpu/cpu[0-9]*; do
    cpu_number=$(basename $cpu_path | sed 's/^cpu//')
    echo "Setting max frequency of CPU $cpu_number to $frequency kHz"
    sudo cpufreq-set -c $cpu_number --max $frequency
done
```
