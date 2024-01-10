---
layout: post
title: "nodejsのnpm"
date: 2024-01-10
excerpt: "nodejsのnpmの使い方"
tags: ["nodejs", "node", "npm"]
config: true
comments: false
sort_key: "2024-01-10"
update_dates: ["2020-01-10"]
---

# nodejsのnpmの使い方

## 概要
 - nodejsのパッケージマネージャ
 - node package managerの略
 - `prefix`でインストール先のディレクトリを指定できる
   - `--prefix $HOME/.opt`とすると、binのpathが`$HOME/.opt/node_modules/.bin`となる
 - `-g`, `--global`オプションで全ユーザから見れるようになる(つけないとローカルユーザ)
   - デフォルトでは`/usr/local`にインストールされる

**パッケージのインストール**
```console
$ npm install <package> -g
```

**パッケージのアンインストール**
```console
$ npm uninstall <package> -g
```

**パッケージのアップデート**
```console
$ npm update <package> -g
```

**パッケージの検索**
```console
$ npm search <package>
```

**デフォルトのprefixの確認**
```console
$ npm config get prefix
/usr/local
```

**インストールされたパッケージの確認**
```console
$ npm list -g --depth=0
/usr/local/lib
├── corepack@0.19.0
├── fast-cli@3.2.0
├── npm@10.2.5
└── tree-sitter-cli@0.20.7
```
