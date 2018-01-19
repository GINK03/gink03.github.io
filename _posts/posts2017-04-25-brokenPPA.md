---
layout: post
title: "CUDAの壊れたレポジトリを削除する"
date: 2017-04-25
excerpt: ""
tags: [潜在不具合]
comments: false
---

# nvidiaさんしっかりして

## サードパーティのPPAをよく参照するよね

aptで一元管理できて便利だけど、提供されたPPAが壊れているケースが有る

## 修正方法
もう何のPPAかわからなくなっているのが常だと思うので、破損しているdebファイルを提供している会社名からPPAを探り出して、
/etc/apt/sources.list.dから手動で削除する

このあと、apt updateを打つと、PPAを提供していた会社のパッケージをまるごと消せるので、消す

## おつかれさまでした
つかれた
