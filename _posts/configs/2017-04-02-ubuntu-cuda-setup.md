---
layout: post
title:  "cuda 8.0をubuntu 16.04にインストール"
date:   2017-04-02
excerpt: "自分向け資料"
project: false
config: true
tag:
- cuda
comments: false
---

# cuda 8.0をubuntu 16.04にインストール

## STEP 1: CUDNNに関するファイルをダウンロードする

1.  Download Cuda  ( Linux -> x86-64->Ubuntu->16.04->runfile(local))
[cuda](https://developer.nvidia.com/cuda-downloads)

2. Download Cudnn 
[cudnn](https://developer.nvidia.com/cudnn)

```
cudnn-8.0-linux-x64-v5.1.tgz
```

3. Download Nvidia GPU driver 
[Driver](http://www.nvidia.co.jp/Download/index.aspx?lang=jp)

```
Yuri（GPUサーバ)のケース：
GeForce
GeForce 10 Series
GeForce GTX 1080
Linux 64-bit
```

## STEP 2: ドライブファイルをインストール''
1. OSのUIをストップ
```
sudo service lightdm stop
```

2. 別のPCでsshで接続して移動して、作業進む
```
chmod +x [ダウンロードしたドライブファイル]
sudo ./[ダウンロードしたドライブファイル]
```

## kernel-develなどで、エラーなら、Install kernel for uname-r User
```
sudo yum install kernel-devel-$(uname-r) gcc 
```

## STEP3 : Bashファイルを再Configure
```
vim .bashrc
```
Adding PATH file(cuda, Export Path)
```
PATH=$PATH:$HOME/bin:/sbin:/usr/sbin:/usr/local/bin:/usr/local/cuda/bin
export PATH
export LD_LIBRARY_PATH=/usr/local/cuda/lib64:$LD_LIBRARY_PATH
```

```
source ~/.bashrc ( reload)
```

## STEP4 : CUDAインストール
```
sudo sh cuda_8.0.61_375.26_linux.run
```
Nvidiaドライバーインストールかを質問された時、「No」を選ぶ。

## STEP5 : CUDNNファイルをインストール
```
tar xvf  <cudnn file > 
```

Copy files inside cuda/include folder to /usr/local/include
```
sudo cp -r cuda/include/*  /usr/local/include
```

copy files in cuda/lib64 to /usr/local/lib and /usr/local/lib64
```
sudo cp -r cuda/lib64/*  /usr/local/lib64
```

```
sudo ldconfig ( reload config )
```

## STEP6 : TEST

Check pycuda
```
sudo pip3 install pycuda
```
if able to install -> done
if error, copy all from /usr/local/cuda/include to /usr/local/include
and /usr/local/cuda/lib64 to /usr/local/lib64

```
cd /usr/local/cuda/lib64 
sudo cp -r * /usr/local/lib64/
cd /usr/local/cuda/include 
sudo cp -r * /usr/include
```

Install tensorflow  
```
sudo pip3 install tensorflow-gpu
import tensorflow 
```
