---
layout: post
title: "systemd service"
date: 2020-04-30
excerpt: "systemd serviceの使い方"
tags: ["linux", "systemd", "systemctl"]
config: true
comments: false
sort_key: "2021-12-23"
update_dates: ["2021-12-23","2021-11-28","2021-09-16","2021-09-07","2021-09-07","2021-09-07","2021-07-09","2020-05-01","2020-04-30"]
---

# systemd serviceの使い方

## 概要
 - systemdは一般的にプロセスをデーモナイズするときに便利なLinuxのサービスの一つ
 - systemdは[/systemctl/](/systemctl/)コマンドで操作される
 - systemdの設定のパス
   - `/etc/systemd/system/`
     - システムの管理するunit
   - `/usr/lib/systemd/system`
     - ディストリビューションが管理するunit
   - `~/.config/systemd/user`
     - 一般ユーザが管理するunit
     - 配置することでユーザ権限でサービスを作成する事ができる

## systemdのスタート/有効化/無効化/確認
 - スタート
   - `sudo systemctl start hoge.service`
 - 有効化
   - `sudo systemctl enable hoge.service`
 - 無効化
   - `sudo systemctl disable hoge.service`
 - 状態の確認(詳細)
   - `systemctl status hoge.service`
 - 状態の確認(簡単)
   - `systemctl is-active hoge.service`
 - 使用できるユニット一覧を表示
   - `systemctl list-unit-files`
 - 設定ファイルの再読み込み
   - `sudo systemctl reload`

## ユーザ作成のスクリプト/プログラムが使用できるsystemdの作成
 - 使用するbinのPATHを通す必要がある。  
 - `echo $PATH` した内容をPATHに追加することでユーザの環境変数で設定されているPythonを動作させることができる。

**ユーザ権限でユーザのbinを用いて特定のプロセスを動かしたいとき**
```
[Unit]
Description=AUTO BACKUP SERVICE
After=network.target
StartLimitIntervalSec=0
[Service]
Type=simple
Restart=always
RestartSec=5
User=<username>
Environment=PATH=<追加したいPATHを網羅したもの>
ExecStart=/usr/bin/env python3 <any python script>
[Install]
WantedBy=multi-user.target
```

### 配置

```console
$ sudo cp hoge.service /etc/systemd/system
```

## ユーザのディレクトリに配置する場合
 - [/systemd-service-user/](/systemd-service-user/)に記載


## 例; `/etc/rc.local`の再現
 - rc.localをスタートアップスクリプトを昔はかけたが、今現在は存在しない。  
 - そのため、`/etc/rc.local`を用意して実行権限を与えて`systemd`で起動するのが主流のやり方であるそう  

**`/etc/systemd/system/rc-local.service`**  
```
[Unit]
Description=/etc/rc.local
ConditionPathExists=/etc/rc.local

[Service]
Type=forking
ExecStart=/etc/rc.local start
TimeoutSec=0
StandardOutput=tty
RemainAfterExit=yes
SysVStartPriority=99

[Install]
WantedBy=multi-user.target
```

**`/etc/rc.local`**  
```shell
#!/bin/sh -e

# firewallを無効化
iptables -I INPUT -j ACCEPT 
```

## 例; duckduns(dynamic dns)のIP更新を行う
 - duckdnsと呼ばれるdynamic dnsに自分のIPを5分ごとに通知する

```
[Unit]
Description=DUCKDNS SERVICE
After=network.target
StartLimitIntervalSec=0
[Service]
Type=simple
Restart=always
RestartSec=5
User=<username>
ExecStart=sh -c "curl \"https://www.duckdns.org/update?domains=gimpeik&token=*********************&ip=&verbose=true\"; sleep 300"
[Install]
WantedBy=multi-user.target
```
