---
layout: post
title: "ssh-keygen"
date: 2023-04-04
excerpt: "ssh-keygenの使い方"
project: false
config: true
tag: ["ssh", "ssh-keygen"]
comments: false
sort_key: "2023-04-04"
update_dates: ["2023-04-04"]
---

# ssh-keygenの使い方

## 概要
 - sshで使用する公開鍵と秘密鍵を作成するソフトウェア
 - githubで秘密鍵を登録して使用したり、他のサービスでも使用できる

## アルゴリズムの特徴
 - RSA
   - 大きな素数から作られた数字が素因数分解するのが難しいという事実に基づく
 - ED25519
   - [/楕円曲線暗号/](/楕円曲線暗号/)
     - 離散対数問題になる
   - RSA暗号より計算量が軽いらしい

## 秘密鍵と公開鍵の作成

### RSAの作成

```console
$ ssh-keygen
Generating public/private rsa key pair.
Enter file in which to save the key (<home path>/.ssh/id_rsa):
Enter passphrase (empty for no passphrase): # 入力するとパスワードが必須になる
Enter same passphrase again: # 入力するとパスワードが必須になる
Your identification has been saved in <home path>/.ssh/id_rsa
Your public key has been saved in <home path>/.ssh/id_rsa.pub
The key fingerprint is:
SHA256:krbM0upueBPo3zNsXbYk7spNZGPNd/lBIPYzXhgaIQ0 <user name>@debian
The key's randomart image is:
+---[RSA 3072]----+
|         Eo=.o   |
|          o.= +  |
|           . = o |
|       . o  . =. |
|   .  + S o ..o. |
|  . .= *..+. . ..|
| . ..o=o.= .    .|
|  o +==oo .      |
|   *=o+=o        |
+----[SHA256]-----+
```

### ED25519の作成

```console
$ ssh-keygen -t ed25519
```

### 秘密鍵から公開鍵を作成する

**pubフォーマットの場合**  
```console
$ ssh-keygen -y -f <private-key-path> > <public-key-path>
```

**pemフォーマットの場合**  
```console
$ openssl rsa -in <private-key-path> -pubout > <public-key-path>
```

---

## 参考
 - [SSH 鍵/wiki.archlinux.jp](https://wiki.archlinux.jp/index.php/SSH_%E9%8D%B5)
 - [Upgrade Your SSH Key to Ed25519/medium](https://medium.com/risan/upgrade-your-ssh-key-to-ed25519-c6e8d60d3c54)
