---
layout: post
title: "code-server"
date: 2023-10-24
excerpt: "code-serverの使い方"
config: true
tag: ["vscode", "microsoft", "code-server", "code"]
sort_key: "2023-10-24"
update_dates: ["2020-10-24"]
comments: false
---

# code-serverの使い方

## 概要
 - vscodeをブラウザ上で動かすことができるoss
 - iPadなどのモバイル端末でもvscodeを使える
 - ossなので拡張機能の一部が使えない
   - e.g. GithubCopilot
   - vsixファイルをダウンロードしてインストールすることはできる
 - https化することで、マークダウンのプレビューやjupyter-notebookの実行も可能
   - 実質、https化は必須

## インストール

**linux**
```console
$ curl -fsSL https://code-server.dev/install.sh | sh
```

## サービスとして追加

```console
$ sudo systemctl enable code-server@$USER
$ sudo systemctl start code-server@$USER
```

### 設定
 - パス
   - `~/.config/code-server/config.yaml`
 - IPの制限を解除
 - 認証機能を解除

```config
bind-addr: 0.0.0.0:9090
auth: none
cert: false
```

## VSIXファイルのインストール
 - code-serverが起動しているコンピュータにVSIXファイルをアップロード
 - `$ code-server --install-extension ~/<vsixファイル名>`
 - code-serverの拡張機能の画面で `Reload Window` をクリック


## 参考
 - [Coding on iPad using VSCode, Caddy, and code-server](https://tailscale.com/kb/1166/vscode-ipad/)
