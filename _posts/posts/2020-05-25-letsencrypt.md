---
layout: post
title: "letsencrypt"
date: 2020-05-25
excerpt: ""
tags: [Let's encrypt]
comments: false
---

# Let's Encrytp 

サイトをフリーでSSL対応させるもの

## 公式サイト

 - https://certbot.eff.org/lets-encrypt/ubuntufocal-other

## Ubuntuでの利用

```console
$ sudo apt install certbot
```


## 初期設定：承認

```console
$ sudo certbot certonly --standalone
```

## SSL証明書の更新

数ヶ月に一回、行う必要があるようだ

```console
$ sudo certbot renew
```

公式では `cron` や `systemctl` で制御することを勧めている


## キーの場所

`cert.pem` と `fullchane.pem` からなっている  
`/etc/letsencrypt/live/{HOSTNAME}` になっており、この中のファイルは最新のバージョンの `cert.pem` と `fullchane.pem` のリンクになっている。    

本体は `/etc/letsencrypt/archive/{HONSTNAME}/[cert|fullchane]{VERSION_NUMBER}.pem` になっている。 

ユーザはこのフォルダを見ることが出来ないので、 `sudo chown -R {USER} /etc/letsencrypt/archive` などしておくと参照できる
