---
layout: post
title: "systemd service"
date: 2024-10-23
excerpt: "userで動作するsystemd serviceの使い方"
tags: ["linux", "systemd", "systemctl"]
config: true
comments: false
sort_key: "2024-10-23"
update_dates: ["2024-10-23"]
---

# userで動作するsystemd serviceの使い方

## 概要
   - 一般ユーザが管理するunit
   - 以下のパスに配置することでユーザ権限でサービスを作成する事ができる
     - `~/.config/systemd/user`

## ユーザ権限のsystemdの作成
 - systemdのパス
   - `~/.config/systemd/user/<service-name>.service`
 - 実行|停止|有効化|無効化
   - `systemctl --user start|stop|enable|disable <foo>`
 - ログの確認
   - `journalctl --user -u <service-name>.service`
 - ユーザのデーモンのリロード
   - `systemctl --user daemon-reload`
 - オプション
   - ユーザがログインしていなくてもサービスを起動する
     - `sudo loginctl enable-linger $USER`

## サンプル(bore serverの起動)

 - サービスの作成
   - `~/.config/systemd/user/bore-server.service` を作成

```bash
[Unit]
Description=Bore Server User Service
After=network.target

[Service]
ExecStart=%h/.cargo/bin/bore server
Restart=on-failure
RestartSec=5s

[Install]
WantedBy=default.target
```

 - サービスの有効化|起動
   - `systemctl --user enable bore-server.service`
   - `systemctl --user start bore-server.service`
