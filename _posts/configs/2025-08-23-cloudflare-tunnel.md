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

## トンネルの確認

```console
$ cloudflared tunnel list
You can obtain more detailed information for each tunnel with `cloudflared tunnel info <name/uuid>`
ID                                   NAME      CREATED              CONNECTIONS
XXXXXXXX-f645-4870-8b1c-320d1e01175f XXXXXXX   2022-10-03T01:49:51Z 1xnrt01, 1xnrt07, 1xnrt08, 1xnrt12
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

### Linuxでcloudflaredのサービスの更新
 1. `~/.cloudflared/config.yml`を編集して設定を変更
 2. `sudo systemctl uninstall cloudflared`でサービスをアンインストール
 3. `cp ~/.cloudflared/config.yml /etc/cloudflared/config.yml`で設定ファイルをコピー
 4. `sudo cloudflared --config /etc/cloudflared/config.yml service install` でサービスをインストール
 5. `sudo systemctl start cloudflared`でサービスを起動
 6. `sudo systemctl status cloudflared`でサービスの状態を確認
 7. `sudo journalctl -u cloudflared -f`でログを確認


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
