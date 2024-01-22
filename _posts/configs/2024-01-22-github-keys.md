---
layout: post
title: "github keys"
date: 2024-01-22
excerpt: "github keysの使い方"
project: false
config: true
tag: ["github", "公開鍵", "keys", "セキュリティ"]
comments: false
sort_key: "2024-01-22"
update_dates: ["2021-01-22"]
---

# github keysの使い方

## 概要
 - githubはsshでの接続を推奨している
 - 公開鍵を登録することで、パスワードなしで接続できるようになる
 - また、`https://github.com/<user>.keys`にアクセスすることで、公開鍵を取得できる 
   - ubuntuのインストール時に、ユーザ名を指定することで、公開鍵を登録できる

## 例

```console
$ curl https://github.com/torvalds.keys
ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCoQ9S7V+CufAgwoehnf2TqsJ9LTsu8pUA3FgpS2mdVwcMcTs++8P5sQcXHLtDmNLpWN4k7NQgxaY1oXy5e25x/4VhXaJXWEt3luSw+Phv/PB2+aGLvqCUirsLTAD2r7ieMhd/pcVf/HlhNUQgnO1mupdbDyqZoGD/uCcJiYav8i/V7nJWJouHA8yq31XS2yqXp9m3VC7UZZHzUsVJA9Us5YqF0hKYeaGruIHR2bwoDF9ZFMss5t6/pzxMljU/ccYwvvRDdI7WX4o4+zLuZ6RWvsU6LGbbb0pQdB72tlV41fSefwFsk4JRdKbyV3Xjf25pV4IXOTcqhy+4JTB/jXxrF
```
