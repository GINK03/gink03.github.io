---
layout: post
title: "sshd security"
date: 2024-01-13
excerpt: "sshdのsecurityについて"
project: false
config: true
tag: ["ssh", "sshd", "security", "linux", "macOS"]
comments: false
sort_key: "2024-01-13"
update_dates: ["2020-01-13"]
---

# sshdのsecurityについて

## 概要
 - debianのsshdはデフォルトではrootログインが許可、パスワード認証が許可されているので適切な設定が必要
 - 一般的に以下の設定が行われていれば十分な対応
   - rootログインを禁止
   - パスワード認証を禁止
   - 公開鍵暗号方式(ECDSA, ED25519)のみを許可

## 設定
 - `/etc/ssh/sshd_config`を編集する

**以下を追記**
```conf
PermitRootLogin no
PasswordAuthentication no
```

## sshdサービスの再起動

**debian**
```console
$ sudo systemctl restart sshd
```

**ubuntu**
```console
$ sudo systemctl restart ssh
```

## 補遺

### debianでのsshdのログの確認

```console
$ sudo journalctl -u ssh
```

### 2024-01-13の攻撃されたときのログ

```console
 1月 13 14:55:30 Kichijouji sshd[437841]: Connection closed by invalid user admin 5.252.118.227 port 44476 [preauth]
 1月 13 14:55:31 Kichijouji sshd[437845]: Invalid user admin from 5.252.118.227 port 44482
 1月 13 14:55:31 Kichijouji sshd[437845]: Connection closed by invalid user admin 5.252.118.227 port 44482 [preauth]
 1月 13 14:55:33 Kichijouji sshd[437847]: Invalid user admin from 5.252.118.227 port 44496
 1月 13 14:55:33 Kichijouji sshd[437847]: Connection closed by invalid user admin 5.252.118.227 port 44496 [preauth]
 1月 13 14:55:34 Kichijouji sshd[437849]: Invalid user topomaps from 85.209.11.226 port 27686
 1月 13 14:55:34 Kichijouji sshd[437849]: Received disconnect from 85.209.11.226 port 27686:11: Client disconnecting normally [preauth]
 1月 13 14:55:34 Kichijouji sshd[437849]: Disconnected from invalid user topomaps 85.209.11.226 port 27686 [preauth]
 1月 13 14:55:34 Kichijouji sshd[437851]: Invalid user admin from 5.252.118.227 port 44508
 1月 13 14:55:35 Kichijouji sshd[437851]: Connection closed by invalid user admin 5.252.118.227 port 44508 [preauth]
```

### ログインを試みたIPアドレスの国別の頻度

| country         |   count |
|:----------------|--------:|
| China           |   13418 |
| United States   |    8197 |
| The Netherlands |    7794 |
| Singapore       |    6642 |
| Hong Kong       |    5930 |
| India           |    4776 |
| Germany         |    3746 |
| Brazil          |    3433 |
| Vietnam         |    3048 |
| Russia          |    2697 |

### ログインを試みたユーザ名の頻度

| user     |   count |
|:---------|--------:|
| ubuntu   |    6813 |
| admin    |    4877 |
| user     |    4755 |
| test     |    3501 |
| debian   |    1960 |
| postgres |    1352 |
| oracle   |    1247 |
| support  |     984 |
| deploy   |     949 |
| sysadmin |     928 |
