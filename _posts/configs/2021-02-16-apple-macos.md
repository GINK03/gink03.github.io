---
layout: post
title: "macOS"
date: 2021-02-16
excerpt: "macOSで設定しておくべき項目とインストールするべきソフトウェアとトラブルシューティング"
tags: ["apple", "macos", "osx", "settings"]
config: true
comments: false
sort_key: "2022-05-23"
update_dates: ["2022-05-23","2022-05-02","2022-04-29","2022-04-28","2022-04-28"]
---

# macOSで設定しておくべき項目とインストールするべきソフトウェアとトラブルシューティング

## 名称の変更
 - 2016年に`iOS`, `tvOS`, `watchOS`などとの統合性を図るために、`osx`から`macOS`に変更された

## 設定しておくべき項目
 - Dockを自動的に隠す + Dockを右に寄せる
   - `[システム設定]` -> `[Dockとメニューバー]` -> `[Dockを自動的に表示/非表示]のチェックを入れる`
   - `[システム設定]` -> `[Dockとメニューバー]` -> `[画面上の位置]で右を選択`
 - メニューバーを自動的に隠す
   - `[システム設定]` -> `[Dockとメニューバー]` -> `[メニューバーを自動的に表示/非表示]のチェックを入れる`
 - 外部からのsshを許可する
   - `[システム設定]` -> `[共有]` -> `[リモートログイン]のチェックを入れる`
 - スクリーンセーバーを無効にする
   - `[システム設定]` -> `[デスクトップとスクリーンセーバー]` -> `[開始までの時間]` -> `開始しない,を選択`
   - `[システム設定]` -> `[省エネルギー]` -> `[ディスプレイをオフにするまでの時間]を, しないに設定`
 - ホットコーナーからMission Controlを起動する
   - `[システム設定]` -> `[Mission Control]` -> `[ホットコーナー]` -> `Mission Controlを割り当て`
 - Mission Controlの自動並び替えをOFFにする
   - `[システム設定]` -> `[Mission Control]` -> `最新の使用業況に基づいて操作スペースを自動的に並び替えを行う`をOFFにする
 - カーソルを大きくする
   - `[システム設定]` -> `[アクセシビリティ]` -> `[ディスプレイ]` -> `[カーソル]` -> `カーソルサイズを大きくする`
 - apple watchでPCのセキュリティを解除
   - `[システム設定]` -> `[セキュリティとプライバシー]` -> `[Apple Watchを使って...]にチェックを入れ、iPhoneとApple Watchをアクティブにする`
 - Bluetoothのアイコンをメニューバーに表示する
   - `[システム設定]` -> `[Bluetooth]` -> `[メニューバーにBluetoothを表示]にチェックを入れる`
 - 入力ソースを限定する
   - `[システム設定]` -> `[キーボード]` -> `[入力ソース]から必要がないキーボードを削除する`
 - launchpadの起動ショートカットを変更する
   - `[システム設定]` -> `[キーボード]` -> `[Launchpad]` -> `[Launchpadを表示]に(alt+d)等を割当`
 - windowの切り替えショートカットを`command + @`から変更する
   - chrome等を複数window開いているとき、windowの切り替えができると嬉しい
   - `[システム設定]` -> `[キーボード]` -> `[ショートカット]` -> `[キーボード]から[次のウィンドウを捜査対象にする]に(alt+tab)等を割り当てる` 
 - ctrl2回で音声入力になるのを変更する
   - `[システム設定]` -> `[キーボード]` -> `[音声入力]` -> `[ショートカット]` -> `衝突しにくいショートカットに変更`

---

## インストールするべきソフトウェア
 - パッケージマネージャ
   - `brew`
 - ターミナルエミュレータ
   - `iterm2`
   - `kitty`
   - `wezterm`
 - ブラウザ
   - `google chrome`
 - 日本語入力
   - `google日本語入力`
 - キーバインド、ショートカット変更
   - `karabiner elements`
 - ランチャー
   - `raycast` 
 - VPN
   - `wireguard`
 - カメラフィルタ
   - `snap camera`
 - ネットワークカメラ
   - `iriun webcam`
 - デスクトップ
   - `magnet`
   - `haze over`: アクティブなウインドウ以外暗くする
   - `hidden bar`: 散らかったメニューバーの整理
   - `easyres`: 解像度のクイック変更
 - オンラインストレージ
   - `google-drive`
   - `onedrive`
   - `mountain-duck`: 好きなオンラインストレージやS3をマウントできる

---

## macOSでのメモリと仮想メモリの特性
 - pythonなどで明らかに物理メモリに乗らない処理をしても、macOSは積極的に仮想メモリを確保し、落ちることがない
   - 仮想メモリを利用するような処理を行ってしまうと、遅くなる
 - linuxなどでは、[OOM killer](https://neo4j.com/developer/kb/linux-out-of-memory-killer/)により、割とすぐにプロセスがkillされるのと対象的

---

## スクリーンショットとスクリーンレコーディングの仕方
 - [/apple-macos-screenshots/](/apple-macos-screenshots/)

---

## トラブルシューティング
 - [/apple-macos-trouble-shootings/](/apple-macos-trouble-shootings/)

## セキュリティ

### sudo時のパスワードを省略する
 - `sudo visudo`して以下の内容を末尾に書き込む

```config
%admin          ALL=(ALL) NOPASSWD:ALL
```

---

## ネットワーク

### インターフェースに複数のIPアドレスを設定する

**en0に192.168.3.129を追加**  
```console
$ sudo ifconfig en0 alias 192.168.3.129/24 up
```

**en0から192.168.3.129を削除**  
```console
$ sudo ifconfig en0 -alias 192.168.3.129
```

### routeの確認

```console
$ netstat -rn | less
```

### routeの変更

**defaultの変更**  
```console
$ sudo route delete default
$ sudo route add default 192.168.3.1
```

**特定のIPを違うgwへ**  
```console
$ sudo route add -host <ip-addr> 192.168.3.1
```

### ネットワークのパフォーマンスを調査する
 - macOSに`networkQuality`コマンドが含まれる
 - [oss](https://github.com/network-quality/server)で開発されている
 - [/netperf/](/netperf/)に替わるパフォーマンス測定ツール

**使用例**  
```console
$ networkQuality
==== SUMMARY ====
Upload capacity: 27.709 Mbps
Download capacity: 33.040 Mbps
Upload flows: 20
Download flows: 12
Responsiveness: Medium (357 RPM) # 一分間でのラウンドトリップ回数
```

### terminalからwifiの情報を表示する

```console
$ ln -s /System/Library/PrivateFrameworks/Apple80211.framework/Resources/airport /usr/local/bin/airport
$ airport -I
```

**使用例**
```console
$ airport -I
     agrCtlRSSI: -56
     agrExtRSSI: 0
    agrCtlNoise: -92
    agrExtNoise: 0
          state: running
        op mode: station
     lastTxRate: 867
        maxRate: 867
lastAssocStatus: 0
    802.11 auth: open
      link auth: wpa2-psk
          BSSID:
           SSID: おもちネットワーク1F
            MCS: 9
  guardInterval: 800
            NSS: 2
        channel: 100,80
```

---

## sshdでパスワード認証を無効化する

`/etc/ssh/sshd_config`に以下を追加

```
PasswordAuthentication no
UsePAM no
```

sshdを再起動する

```console
$ sudo launchctl stop com.openssh.sshd
$ sudo launchctl start com.openssh.sshd
```

---

## launchctlでサービスの管理を行う
 - 概要
   - plist形式で作成されたファイルに対して操作できる
   - `/Library/LaunchAgents`はrootで操作可能
   - `~/Library/LaunchAgents`はユーザ権限で操作可能
 - 基本的な操作
   - すべてのサービスを表示
     - `launchctl list`
   - サービスの有効化
     - `launchctl load <service-name or plist-path>`
   - サービスの無効化
      - `launchctl unload <service-name>`
   - サービスの停止
      - `launchctl stop <service-name>`
   - サービスの開始
      - `launchctl start <service-name>`
 - 参考
   - [launchdで定期的にスクリプトを実行/Qiita](https://qiita.com/rsahara/items/7d37a4cb6c73329d4683)

---

## バッテリーの状態をCUIで取得する

```console
$ pmset -g batt
Now drawing from 'AC Power'
 -InternalBattery-0 (id=5767267)        61%; AC attached; not charging present: true
```

---

## finder

### ターミナルの特定のpathからfinderを開く

```console
$ open .
```

### ターミナルの特定のファイルをosxのアプリで開く

```console
$ open <filename>
```
 - デフォルトで開くアプリを設定するには`ファイルを右クリック` -> `このアプリケーションで開く` -> `その他` -> `常にこのアプリケーションで開く`を選ぶ

### ターミナルからアプリを起動する
 - `/Applications/<PackageName>.app`があるとき、以下のコマンドで起動できる

```console
$ open -a "PackageName"
```

 - 一部のアプリケーションには引数を渡すことができる

```console
$ open -a "Microsoft Edge" "https://duckduckgo.com"
```

### ゴミ箱を空にする
 - finderでゴミ箱の隠しフォルダを開く
 - finder上からゴミ箱を空にする(terminalからは消去が禁止されている)

```console
$ cd ~/.Trash
$ open .
```

---

## Dock

### Dockの無効化
 - 概要
   - dockはシステムのサービスと統合されているので、削除やアンインストールはできない
   - dockが自動的に隠れてから再度表示するまでの時間を指定できるので大きな値を設定することで、実質的な無効化が行える

```console
$ alias hideDock="defaults write com.apple.dock autohide-delay -float 3600; killall Dock"
$ hideDock
```

---

## シェルスクリプトなどをosxの`app`にする
 - 特定のdockerやjupyterなどを起動するときのスクリプトとしてダブルクリックで開けるものを用意したい時など

### アプリ化するスクリプト

```shell
#!/usr/bin/env bash

APPNAME=${2:-$(basename "${1}" '.sh')};
DIR="${APPNAME}.app/Contents/MacOS";

if [ -a "${APPNAME}.app" ]; then
	echo "${PWD}/${APPNAME}.app already exists :(";
	exit 1;
fi;

mkdir -p "${DIR}";
cp "${1}" "${DIR}/${APPNAME}";
chmod +x "${DIR}/${APPNAME}";

echo "${PWD}/$APPNAME.app";
```

これをappifyという名前で保存し、以下のコマンドで作成できる

```console
$ appify script-name.sh "app-name"
```
 - [参考](https://mathiasbynens.be/notes/shell-script-mac-apps)

---

## MacとUSB Type-Cと接続したときの通信速度の確認
 - 概要
   - USB Type-CはケーブルによりUSB 2.0の速度、USB 3.1の速度が出せるものなどが混在している
   - データの転送を行う際には実際に接続して確認する必要がある
 - 確認方法
   - 左上のリンゴマークから`このマックについて`を選択
   - `概要` -> `システムレポート`を選択
   - `ハードウェア` -> `USB`を選択
   - USBバスから対象デバイスを選択
     - 速度が10Gb/秒になっていればUSB 3.1接続である

<div>
  <img src="https://user-images.githubusercontent.com/4949982/166181243-deab3808-aa57-41cf-ac07-0dea9a13ea37.png">
</div>

---

## SMB(Server Message Block)のマウント
 - [/apple-macos-file-sharing/](/apple-macos-file-sharing/)

---

## macOSのファイルシステム
 - `APFS`
   - SSDに対応したファイルシステム
   - 2016年から
 - `HFS+(Mac OS拡張)`
   - HDDを前提としたファイルシステム
 - 参考
   - [APFS vs MacOS拡張(HFS+)：違いとMacでフォーマットする方法 [MiniTool]](https://jp.minitool.com/data-recovery/apfs-vs-mac-os-extended-difference-and-format.html)

---

## linuxのnfsをマウントする
 - CUI
   - マウント
     - `# mount -t nfs mount -t nfs -o resvport ${HOSTNAME}:${PATH} ${LOCAL_PATH}`
   - アンマウント
     - `# diskutil unmount force ${LOCAL_PATH}`
 - サーバサイドに期待する設定
   - `/etc/exports`のファイルにて`anonuid=1000,anongid=1000,insecure,all_squash`がパラメータとして入っている必要がある
