---
layout: post
title: "cuda + cudnnのセットアップ"
date: "2017-04-02"
excerpt: "cuda"
project: false
config: true
tag: ["nvidia", "cuda", "cudnn"]
comments: false
sort_key: "2018-01-19"
update_dates: ["2018-01-19"]
---

# cuda + cudnnのセットアップ

## 手順
 - STEP 1: CUDA, CUDNN, Driverのファイルをダウンロードする
   - 1. Download Cuda  (Linux -> x86-64 -> Ubuntu -> xx.yy(version) -> runfile(local))
     - [cuda](https://developer.nvidia.com/cuda-downloads)
   - 2. Download Cudnn 
     - [cudnn](https://developer.nvidia.com/cudnn)
   - 3. Download Nvidia GPU driver 
     - [Driver](http://www.nvidia.co.jp/Download/index.aspx?lang=jp)
 - STEP 2: ドライブファイルをインストール
 - STEP 3: CUDAインストール
 - STEP 4: CUDNNファイルをインストール
 - STEP 5: shared objectのリンク情報をリフレッシュ
   - `$ sudo ldconfig`

## 手動でshared objectを配置する

```console
$ cd /usr/local/cuda/lib64 
$ sudo cp -r * /usr/local/lib64/
$ cd /usr/local/cuda/include 
$ sudo cp -r * /usr/include
$ sudo ldconfig
```

