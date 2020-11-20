---
layout: post
title:  "microsoft remote desktop"
date:   2020-11-06
excerpt: "microsoft remote desktop"
project: false
config: true
tag: ["microsoft remote desktop"]
comments: false
---

# microsoft remote desktop

## server side

`settings` -> `enable remote desktop`のスイッチを有効にする

**port and protocols**  
 - 3389
 - tcp/udp

## client side 

**macosx**  
`app store` -> (microsoft remote desktopを検索) -> (onlineで設定したmicrosoft accountのメールアドレスとパスワードでログイン可能)  

13inchのMacBookでは解像度が`2560x1600`であるので、これの半分の`1280x800`か、0.75倍の`1920x1200`などだときれいに映る  

**ios**  
`app store` -> (microsoft remote desktopを検索) -> (onlineで設定したmicrosoft accountのメールアドレスとパスワードでログイン可能)  

**remmina**
Linuxで使うときなど  
完成度は完璧でなはないが、そこそこ使える  
```console
$ sudo snap install remmina
```

**起動**
```console
$ sudo remmina
```

`New Connection Profile`でprofileを新規作成する
 - `Server` : local IPアドレス
 - `Username` : Microsoft Online Accountのメールアドレス
 - `Password` : Microsoft Online Accountのパスワード
 - `Domain` : なし
 - `Resolution` : `Use client resolution`にチェック
 - `Colour depth` : `RemoteFX(32 bpp)`
 - `Quality` : `Best(slowest)`
 - `Sound` : `Local - high quality`
 - `Security` : `Negotiate`
 - `Ignore certificate` : check on
 - `Glyph cache` : check on
