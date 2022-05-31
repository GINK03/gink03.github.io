---
layout: post
title: "Deep Photo Style Transfer"
date: 2017-04-08
excerpt: ""
tags: [DeepLearning]
comments: false
---
# 編集中
<p align="center">
    <img align="" width="350" float="left" src="https://cloud.githubusercontent.com/assets/4949982/24794576/168df000-1bc1-11e7-814d-2963edb06d92.png">
    <img align="" width="350" src="https://cloud.githubusercontent.com/assets/4949982/24794570/151441b6-1bc1-11e7-959d-5e86d293f996.png">
</p>
<div align="center"> 図1. 赤色のオリジナル画像と水との合成 </div>
<p align="center">
    <img align="" width="350" float="left" src="https://cloud.githubusercontent.com/assets/4949982/24794583/198c3c76-1bc1-11e7-81ae-43cf35d9ac9a.png">
    <img align="" width="350" src="https://cloud.githubusercontent.com/assets/4949982/24794585/1ad43e9e-1bc1-11e7-94af-2ede175f0d15.png">
</p>
<div align="center"> 図2. 青のビロードと、黒のビロードの合成</div>

<p align="center">
    <img align="" width="250" height="166" float="left" src="https://cloud.githubusercontent.com/assets/4949982/24803060/ffd262aa-1be4-11e7-96bb-8623afcb478c.png">
    <img align="" width="250" height="166" float="left" src="https://cloud.githubusercontent.com/assets/4949982/24803062/0241a276-1be5-11e7-8096-c1c24883835f.png">
    <img align="" width="250" height="166" src="https://cloud.githubusercontent.com/assets/4949982/24803070/079743e8-1be5-11e7-8156-4651f8ae1b0c.png">
</p>
<div align="center"> 図3. イラストの海と、写真の海を合成 </div>

<p align="center">
    <img align="" width="250" height="166" float="left" src="https://cloud.githubusercontent.com/assets/4949982/24803615/b469060a-1be6-11e7-978a-551e3fb242da.png">
    <img align="" width="250" height="166" float="left" src="https://cloud.githubusercontent.com/assets/4949982/24803618/b643b394-1be6-11e7-9a3e-3f208dd2fe0f.png">
    <img align="" width="250" height="166" src="https://cloud.githubusercontent.com/assets/4949982/24803629/bdba426e-1be6-11e7-8284-216feb46256b.png">
</p>
<div align="center"> 図4. ダリアと桜の合成</div>


<p align="center">
    <img align="" width="250" height="166" float="left" src="https://cloud.githubusercontent.com/assets/4949982/24803443/36ab0d94-1be6-11e7-8913-724dc6b7b3a9.jpg">
    <img align="" width="250" height="166" float="left" src="https://cloud.githubusercontent.com/assets/4949982/24803444/387bf520-1be6-11e7-952c-338cff34288a.png">
    <img align="" width="250" height="166" src="https://cloud.githubusercontent.com/assets/4949982/24803453/3e61e2d8-1be6-11e7-8089-afd1b9c0b30c.png">
</p>
<div align="center"> 図5. 化物語の阿良々木暦とその声優の神谷さん</div>

<p align="center">
    <img align="" width="250" height="166" float="left" src="https://cloud.githubusercontent.com/assets/4949982/24804708/564976dc-1bea-11e7-92c4-6f173d28cc5a.jpg">
    <img align="" width="250" height="166" float="left" src="https://cloud.githubusercontent.com/assets/4949982/24804703/4f6fd126-1bea-11e7-9973-2fdb7f1f7a7c.png">
    <img align="" width="250" height="166" src="https://cloud.githubusercontent.com/assets/4949982/24804711/60044364-1bea-11e7-94b8-2d257163eb87.png">
</p>
<div align="center"> 図5. 夏の森に桜</div>

# Adobeっぽい

## コードが色々あれ
- パラメータの連結にstr(foo) + " bar " + str(alice) + "bob"　みたいなことやりまくっててなんだかよくわからない
- Matlabを使用していることもあり、プロプライエタリ万歳な空気を感じる(Octave対応には別途、書き換える必要があり、とにかく遅い)

## 出力した画像が非常に美しい
- 全く別の分野から画像を持ってきて合成することができるので、とても流麗な画像を作ることができる 
- 幾つか私が実験して作成した映像を添付する

## 改修点
- Python3でbatchを実行できるように変更
- バッチで全部処理するプログラムから、一個一個config.jsonを読んで処理するスタイルへ変更
- GPUを指定できるように変更
- Matlab, Octave双方に対して対応
- iterationの回数を指定可能

## ノウハウ
### step2の学習の収束が独自のデータの学習の収束が失敗することがあり、いくつか成功させる方法を編み出した
どうやら画像の収束に失敗する場合、画像の大きさや、画像に含まれている情報が関連するらしく、いくら小さくしても、情報量を削ってもうまくいかない。  
非常にバカっぽいが、成功が約束されているサンプルのinput画像に変更したい画像を組み込むことでうまくいくことがわかった。  
この方法では、最終的な出力物から、目的以外のデータを削って削除する必要があるがある程度安定して、画像の変換ができる。  

### Octaveのラプラシアンの作成の遅さについて  
壊滅的に遅いので、じっと忍耐強く待つ（5分くらい）のみである。dispという、consoleにステータスを表示するコマンドもうまく動作しない。  
実験レベルを超えて実務で使用する必要がある場合は、迷わずmatlab買ったほうが良いような気がしたが、OSSしか認めない人もいるので、判断はおまかせ。  

### Makefileのハック
torch7がインストールされている必要があり、include fileやlib fileが読み込めなかったので、以下のように変更する
```makefile
PREFIX       := $(HOME)/torch/install                                           
NVCC_PREFIX  := /usr/local/cuda/bin          
CFLAGS       := -I$(PREFIX)/include/THC -I$(PREFIX)/include/TH -I$(PREFIX)/include -I$(HOME)/torch/install/include/ -I$(HOME)/torch/install/include/THC -I$(HOME)/torch/install/include/TH/                 
LDFLAGS_NVCC := -L$(PREFIX)/lib -Xlinker -rpath,$(PREFIX)/lib -lluaT -lTHC -lTH -lpng
all: libcuda_utils.so                                                
libcuda_utils.so: cuda_utils.cu
  $(NVCC_PREFIX)/nvcc -arch sm_35 -O3 -DNDEBUG --compiler-options '-fPIC' -o libcuda_utils.so \
    --shared cuda_utils.cu \                                                
    $(CFLAGS) $(LDFLAGS_NVCC) \                                         
    -L/home/gimpei/torch/install/lib/                                                                         
clean:                                            
  find . -type f | xargs -n 5 touch                                
  rm -f libcuda_utils.so ```
```

### 結構膨大なGPUメモリが必要
- GPUのメモリは8GByte以上あったほうが鉄板っぽいので、GTX1070, GTX1080, GTX1080Ti以上ほしい

### 収束に失敗したら、別のGPUを使うとうまくいくことがある
- 闇すぎる
```sh
python3 gen.py --gpu 1 -> 0にしてみるとか
```
