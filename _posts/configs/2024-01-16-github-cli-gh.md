---
layout: post
title: "github cli"
date: 2024-01-16
excerpt: "github cliの使い方"
project: false
config: true
tag: ["github", "workflows", "gh", "cli"]
comments: false
sort_key: "2024-01-16"
update_dates: ["2021-01-16"]
---

# github cliの使い方

## 概要
 - gitコマンドとは別にgithubの操作ができるcliに`gh`がある
 - `gh`はプロジェクトの作成、issueの作成、PRの作成、PRのマージなどができる
 - `gh`コマンドでの認証情報は一時的なもので、個人の秘密鍵などは使わないので安全

## インストール

**nix**
```console
$ nix profile install nixpkgs#gh
```

**amazon linux**
```console
$ type -p yum-config-manager >/dev/null || sudo yum install yum-utils
$ sudo yum-config-manager --add-repo https://cli.github.com/packages/rpm/gh-cli.repo
$ sudo yum install gh
```

## ログイン

```console
$ gh auth login
```
  - httpsでの認証を選択
  - terminalに表示される指示に従って、githubのトークンを取得
  - トークンを[Device Activation](https://github.com/login/device/)に入力する
  - ブラウザが開けないエラーを無視しても問題ない

## ログイン情報をgitに使う

```console
$ gh auth setup-git
```

## 認証scopeの変更

```console
$ gh auth refresh --scopes write:org,read:public_key
```

## 基本的な使い方
 - レポジトリ操作
   - `gh repo list` - リポジトリの一覧表示
   - `gh repo clone <repository-name>` - リポジトリのクローン
   - `gh repo create <repository-name>` - リポジトリの作成
   - `gh issue create` - issueの作成
   - `gh pr checkout <pull-request-number>` - PRのチェックアウト
   - `gh pr create` - PRの作成
 - gist操作
   - `gh gist list --limit 10` - gistの一覧表示
   - `gh gist clone <gist-id>` - gistのクローン
   - `gh gist create` - gistの作成
   - `gh gist edit <gist-id>` - gistの編集

## 参考
 - [GitHub CLI manual](https://cli.github.com/manual/)
 - [Installing gh on Linux and BSD](https://github.com/cli/cli/blob/trunk/docs/install_linux.md)
 - [git asks for password despite authentication with gh #4351](https://github.com/cli/cli/issues/4351)
