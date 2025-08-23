---
layout: post
title: "Cloudflare Tunnel" 
date: 2025-08-23
excerpt: "Cloudflare Tunnelの設定方法と使い方"
tag: ["Cloudflare", "Tunnel", "設定方法", "使い方"]
config: true
comments: false
sort_key: "2025-08-23-cloudflare-tunnel.md"
update_dates: ["2025-08-23", "2025-08-24"]
---

# Cloudflare Tunnelの設定方法と使い方

## 概要
 - Cloudflare Tunnel（cloudflared）を用いて、サーバーの特定のポートを安全にインターネットへ公開できる
 - 事前にCloudflareアカウントとそこで登録しているドメインが必要

## トンネルの作成
 - `example.com` というドメインを例に、トンネルを作成する

```console
# ブラウザが開くので Cloudflare アカウントで認証（example.com のゾーンに紐づく）
$ cloudflared tunnel login

# トンネル作成（名前はお好みで）
$ cloudflared tunnel create my-tunnel

# 返ってくる Tunnel UUID を控える（例: a1b2c3...）
# 資格情報 JSON は ~/.cloudflared/<UUID>.json 
```

## DNS ルーティングの設定
 - DNSルーティングの設定は、作成したトンネルを実際のドメイン名と紐づけるために必要
 - ユーザーは覚えやすいドメイン名（例：`my-server.example.com`）でサーバーにアクセスできる

```console
$ cloudflared tunnel route dns my-tunnel my-server.example.com
$ cloudflared tunnel route dns my-tunnel ssh.my-server.example.com
```

## 設定ファイルの作成

**~/.cloudflared/config.yml**
```yaml
# ~/.cloudflared/config.yml
tunnel: <上で控えた UUID>
credentials-file: /home/<あなたのユーザー>/.cloudflared/<UUID>.json

ingress:
  # HTTPS の例: my-server.example.com をこのサーバの HTTP(8080) に公開
  - hostname: my-server.example.com
    service: http://localhost:8080

  # SSH の例: ssh.my-server.example.com をこのサーバの 22 番へ
  - hostname: ssh.my-server.example.com
    service: ssh://localhost:22

  # フォールバック
  - service: http_status:404
```

## トンネルの動作確認とサービス化

**手動実行**
```console
$ cloudflared tunnel run my-tunnel
```

**サービス化（Linux）**
```console
# 設定を読ませてサービス化（rootで実行）
$ sudo cloudflared --config ~/.cloudflared/config.yml service install

# 起動 & 自動起動
$ sudo systemctl start cloudflared
$ sudo systemctl enable cloudflared
$ sudo systemctl status cloudflared
```

**サービス化（macOS）**
```console
$ sudo cloudflared service install
```

## SSH 接続の例

```console
$ ssh -vv \
  -o ProxyCommand='cloudflared access ssh --hostname ssh.my-server.example.com' \
  -i ~/.ssh/id_ed25519 \
  username@ssh.my-server.example.com
```
