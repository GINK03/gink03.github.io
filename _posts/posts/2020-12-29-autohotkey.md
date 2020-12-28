---
layout: post
title: "autohotkey"
date: 2020-12-29
excerpt: ""
tags: ["autohotkey"]
comments: false
---

# AutohotkeyでWindowsをMacように使う

## 2020-12-29追記
 - 現在はMicrosoftのOSSである`powertoys`が代替として公式の提供ということもあり優れている

## ソフトウェアの説明と使い方　

とにかくWindowsとMacの二刀流になってしまうのが不満であったので、Window側設定Macに寄せるものとしてautohotkeyというものがある  

OSレイヤ、softwareレイヤみたいのを仮定したとき、softwareレイヤで動作するのでOSの深いところまではいじれない  

https://autohotkey.com/

installerをインストールして進める必要がある  

仮想デスクトップの動作を似せる設定と、全角半角をctr+spaceに割り当てるだけでだいぶQoLが改善した  

```console
^!s::Run calc.exe
^right::#^right
^left::#^left
^space::Send, {vkF4sc029}
```


