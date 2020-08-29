---
layout: post
title:  "letsencrypt"
date:   2020-08-29
excerpt: "letsencrypt"
project: false
config: true
tag: []
comments: false
---

# letsencrypt


## install

```console
$ sudo snap install certbot
```

## stand alone install 

```console
$ sudo certbot certonly --standalone --preferred-challenges http -d example.com
```

## renew

```console
$ sudo certbot renew
```

## cron

```console
$ sudo crontab -e
```

and edit this line
```console
00 04 01 * * root /snap/bin/certbot renew
```

`crontab -e` で作成されたファイルはUbuntuでは以下のパスに記録される

```console
# ls /var/spool/cron/crontabs
```

dry-runなどをしたいときは以下のコマンドで実行

```console
# run-pars /var/spool/cron/crontabs
```


