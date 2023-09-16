---
layout: post
title: "ubuntu troubleshootings"
date: 2023-09-16
excerpt: "ubuntuのトラブルシューティング"
tags: ["ubuntu", "linux", "トラブルシューティング"]
config: true
comments: false
sort_key: "2023-09-16"
update_dates: ["2023-09-16"]
---

# ubuntuのトラブルシューティング

## ケース別トラブルシューティング

### GUIが正常に動作しない
 - 原因
   - nvidiaのドライバの問題でGUIが起動しないことが有る
 - 対応
   - `sudo systemctl set-default multi-user`でGUIを無効化する

### 起動(再起動)後、しばらくログインできなくなる問題
 - 現象
   - `System is booting up. Unprivileged users are not permitted to log in yet. Please come back later. For technical details, see pam_nologin(8)`とでる
 - 原因
   - ネットワークディスクのマウントや様々なunitの準備が整っていないので、ログインできなくなる現象
   - タイムアウトを待っていると5分程度かかってしまう 
 - 対応
   - 以下のコマンドを実行すると解決することがある

**networkdを待たないようにする**  
```console
# systemctl disable systemd-networkd-wait-online
```

### 起動が遅い
 - 原因
   - systemdで起動に失敗しているサービスがある
 - 対応
   - `systemctl list-units`でfailしているunitを確認する
   - 必要がなさそうなサービスであれば停止する

### 起動時にcachefileのcookieが衝突してしまう
 - `cachefilesd`をアンインストールすることで解決する事がある

### OSがクラッシュする
 - 原因
   - 経験上、メモリが原因の事が多く、メモリを変える・クロック数を減らす・電圧を上げる等で対処すると良い
 - 特定
   - `/var/log/syslog`をチェックする
   - ハードウェアなどが原因でクラッシュしている場合、`^@^@^@^@^@^@^@^@^@^@...`で表現される文字列が含まれる

### aptでパッケージをダウンロードするのが遅い
 - 原因
   - `/etc/apt/sources.list`に記されたレポジトリへのURLが適切でない可能性
 - 対応
   - `jp.`がついている方が遅いことがあり、`jp.`の文字列を削除すると高速化する

### apt updateで`公開鍵を利用できないため、以下の署名は検証できませんでした: NO_PUBKEY xxxxxxx`と警告がでる
 - 原因
   - `/etc/apt/sources.list.d/<filename>`が何らかの不整合を起こしている
 - 対応
   - `sudo rm /etc/apt/sources.list.d/<filename>`を削除すると直る
 - 参考
   - [Apt-get is broken after install Google Cloud SDK on Ubuntu 18.04 LTS/StackOverflow](https://stackoverflow.com/questions/56679191/apt-get-is-broken-after-install-google-cloud-sdk-on-ubuntu-18-04-lts)

### aptのレポジトリがCDROMを参照してしまう場合
 - 原因
   - OSインストール時の何らかの不具合でパッケージマネージャのレポジトリにCDROMが残っている場合がある  
 - 対応
   - `/etc/apt/sources.list`のレポジトリから`deb cdrom:~`をコメントアウトする

### `failed to start default target transaction for graphical.target is destructive...`と表示されて正常に起動しない(rootのエマージェンシーモードになる)
 - 原因
   - nvme ssdなどが故障し、fstabにあるはずのディスクが読めなくなって、エマージェンシーモードに入ってしまっている
 - 対応
   - fstabを編集し、見えないデバイスのマウントをしないように設定する
   - 破損したディスクをコンピュータから外す

### `'us.archive.ubuntu.com' が一時的に解決できません`と表示されて`apt update`ができない
 - 原因
   - 対象のバージョンのubuntuのサポート停止、レポジトリ停止なので更新不能になっている
 - 対応
   - `/etc/apt/sources.list`を書き換えて使用可能なレポジトリに変更する
     - ubuntuのメジャーアップグレードを伴うこともある

### OSのプロセスが異常終了し、再起動すらできない
 - 原因
   - ハードウェアの故障?(ソフトウェア起因であることが経験上少ない, 原因の特定が難しい)
 - 対応
   - `sudo systemctl --force --force reboot`
 - 参考
   - [systemd doesn’t want to reboot](https://svennd.be/systemd-doesnt-want-to-reboot/)

### do-release-upgradeが終了し正常にOSのアップグレードができない
 - 原因
   - `/etc/apt/sources.list.d/`以下の外部のaptソースがアップグレード先のOSに対応していないために発生する
 - 対応
   - `/etc/apt/sources.list.d/`以下の不整合を発生させているソースを削除する

### linuxカーネル更新中にクラッシュしてOSが起動不能になる
 - 原因
   - windowsとのデュアルブードで異常が発生し、`update-grub`に失敗し、カーネルのビルド・設定に失敗する
 - 対応
   - 手動で起動し、古いカーネルを選択して起動し異常が発生しているカーネルをpurgeする
   - windowsとのデュアルブードを行わない
