---
layout: post
title: "geekbenchの使い方"
date: 2025-11-12
excerpt: "geekbenchの使い方"
kaggle: true
tag: ["ツール", "ベンチマーク", "geekbench"]
comments: false
sort_key: "2025-11-12"
update_dates: ["2025-11-12"]
---

# geekbenchの使い方

## 概要
 - ベンチマークツール
 - CPUやGPUの性能を測定するために使用される
 - LinuxでもCUIで動作する
   - CUIの結果はURLが表示されブラウザで確認可能

## インストール方法

**macOS**

```console
$ brew install --cask geekbench
```

**Linux x86_64**

```console
$ wget https://cdn.geekbench.com/Geekbench-6.3.0-Linux.tar.gz
$ tar xf Geekbench-6.3.0-Linux.tar.gz
$ ./Geekbench-6.3.0-Linux/geekbench_x86_64
```

**Linux aarch64**

```console
$ wget https://cdn.geekbench.com/Geekbench-6.2.2-LinuxARMPreview.tar.gz
$ tar xf Geekbench-6.2.2-LinuxARMPreview.tar.gz
$ ./Geekbench-6.2.2-LinuxARMPreview/geekbench_aarch64
```

## 結果

 - **Oracle Cloud Ampere A1（フリーティア）**
   - Single-Core Score: 1080
   - Multi-Core Score: 3495
 - **AMD Ryzen 7 5700G**
   - Single-Core Score: 918
   - Multi-Core Score: 4664
 - **MacBook Pro (14-inch, 2024)**
   - Single-Core Score: 3626
   - Multi-Core Score: 19382
