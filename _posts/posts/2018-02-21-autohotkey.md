---
layout: post
title: "autohotkey"
date: 2018-02-20
excerpt: ""
tags: [autohotkey]
comments: false
---

# AutohotkeyでwindowsをMacように使う

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
