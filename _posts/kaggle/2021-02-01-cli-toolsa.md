---
layout: post
title: "cli-tools"
date: 2021-02-01
excerpt: "コンペティションのcliツールに関して"
kaggle: true
hide_from_post: true
tag: ["kaggle", "cli", "python"]
comments: false
---

# cliツールに関して

## kaggle

```console
$ python3 -m pip install kaggle
```

## signate

```console
$ python3 -m pip install signate
```
 - 認証
   - `~/.signate/signate.json`が必要  
     - [link](https://signate.jp/account_settings#)からapiトークンを発行する  

 - コンペティション一覧を表示
   - `signate list`

 - コンペティションのファイルをダウンロード
   - `signate download --competition={コンペID}`

 - コンペIDについて
   - signateのURLに含まれる数字のこと
