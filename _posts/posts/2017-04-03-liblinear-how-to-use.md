---
layout: post
title: "liblinear tools"
date: 2017-04-03
excerpt: "A ton of text to test readability with image feature."
tags: [liblinear-tools]
feature: http://i.imgur.com/Ds6S7lJ.png
comments: false
---

## インストール
in Unbuntu 16.04 over
```sh
$ sudo apt install libliner-tools
```

## 学習
通常
```sh
$ liblinear-train alice.svm.fmt
```
logistice-regression
```sh
$ liblinear-train -s 0 alice.svm.fmt
```

## 学習結果確認
```sh
$ libliner-predict test.svm.fmt alice.svm.fmt.model result.txt
```
引数に、test.svm.fmtとその学習済みモデルであるalice.svm.fmt.modelが必要
解析対象にtest.svm.fmtsを設定して、必ず第三引数にresult.txtなどの出力先が必要
```sh
$ libliner-predict -b 0 test.svm.fmt alice.svm.fmt.model result.txt
```
確率表記で出力

## 注意事項
svmフォーマットは、indexは1から始まって、昇順になっている必要があるので、ちょっとコードに癖が出る可能性がある
```sh
OK
1 1:0.524 2:3.34 ...
```
```sh
NG 
1 0:0.223 4:2.233 1:2332 ...
```

## ただのregression
```sh
$ ./train -s 11 head.svm
```
