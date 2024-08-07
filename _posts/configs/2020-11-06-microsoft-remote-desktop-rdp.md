---
layout: post
title: "microsoft remote desktop"
date: 2020-11-06
excerpt: "microsoft remote desktop(rdp)の概要"
project: false
config: true
tag: ["microsoft remote desktop", "rdp", "mstsc"]
comments: false
sort_key: "2022-04-28"
update_dates: ["2022-04-28","2022-02-23","2021-09-07"]
---

# microsoft remote desktop(rdp)の概要

## 概要
 - microsoftが開発しているリモートデスクトップのプロトコルとそれを利用したソフトウェア
 - rdpはnetflixの映画など保護された動画コンテンツを送ることができない
 - windowsのリモートデスクトップクライアントは`mstsc`というコマンドで起動できる
   - `mstsc`は`microsoft terminal services client`の略
 - 企業によってはセキュリティの観点から、ローカルPCの機能をほとんど制限し、リモートデスクトップのみを利用するようにしている場合がある
 - リモートデスクトップの中でスクリーンショットを行うには、`snipping tool`を利用する

## server sideの設定
 - Windows Professionalで`settings` -> `enable remote desktop`のスイッチを有効にする
 - Professionalでないremote desktopは音が転送されないなどの制限がある

**port and protocols**  
 - 3389
 - tcp/udp

## client sideの設定

### Windows
 - **起動**
   - `windows` + `r` -> `mstsc`
 - **mstscオプション**
   - `mstsc /v:hostname` - hostnameに接続する
   - `mstsc /admin` - 管理者権限で接続する
   - `mstsc <filename>.rdp` - rdpファイルを読み込む

### macOS
 - **インストール**
   - `app store` -> (microsoft remote desktopを検索) -> (onlineで設定したmicrosoft accountのメールアドレスとパスワードでログイン可能)  
 - **設定**
   - 13inchのMacBookでは解像度が`2560x1600`であるので、これの半分の`1280x800`か、0.75倍の`1920x1200`などだときれいに映る  
   - `Optimize for Retina Displays`と`Update session resolution on resize`を入れても十分に使える  
   - クライアントのosxがコマンドのキーはOS優先なのでCMD + tabなどの挙動でosxに戻ってしまって使い勝手が悪いが、[karabiner elements](/karabiner/)などで無効化できる
 - **制限**
   - ホスト側のショートカットが最初にハンドルされてしまうのでリモートOSに伝達されない
     - e.g.) ctrl + space
     - この制限のため、IMEのキーマップを変更するなどの対応が必要
       - キーマップの再設定には[/powertoys/](/powertoys/)を用いると便利

### iOS
 - **インストール**
   - `app store` -> (microsoft remote desktopを検索) -> (onlineで設定したmicrosoft accountのメールアドレスとパスワードでログイン可能)  
 - **設定**
   - iPad Pro 13inchでは解像度が`2720x1951`が最適
 - **制限**
   - `ctrl + ]`など定義したショートカットの信号が送れないなどの問題があり、ショートカットやキーコンビネーションに難あり

## トラブルシューティング

### グローバルIP接続時にクライアントのWindowsでVPNに接続すると応答がなくなる
 - **原因**
   - グローバルIPはVPNソフトがWindowsのパケットのルーティングを変更するため、リーチできなくなるために発生する
 - **対応**
   - グローバルIPでRDPでアクセスしている場合、VPNを利用しない
