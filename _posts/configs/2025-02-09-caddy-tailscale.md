---
layout: post
title: "caddy tailscale"
date: "2025-02-09"
excerpt: "caddyでtailscaleのIPアドレスをssl化する"
config: true
tag: ["https", "caddy", "reverse proxy", "tailscale"]
comments: false
sort_key: "2025-02-09"
update_dates: ["2025-02-09"]
---

# caddyでtailscaleのIPアドレスをssl化する

## 概要
 - 自己証明書を使用し、tailscaleのIPアドレスをssl化する方法を記載
 - code serverなどを利用する際に必須


## `/etc/caddy/Caddyfile`
 - `https://100.***.***.***`の部分にtailscaleのIPアドレスを記載
 - `tls internal`で自己証明書を使用
 - `reverse_proxy localhost:9090`でlocalhost:9090にアクセスを転送

```caddy
https://100.***.***.*** {
    tls internal
    reverse_proxy localhost:9090
}
```

## `root.crt`をmacOSにインストール
 - `/var/lib/caddy/.local/share/caddy/pki/authorities/local/root.crt`をscpでmacにコピー

**macOS**
```console
sudo security add-trusted-cert -d -r trustRoot -k /Library/Keychains/System.keychain ~/Downloads/root.crt
```
