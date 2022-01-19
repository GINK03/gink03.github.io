---
layout: post
title: "chocolatey"
date: 2020-10-31
excerpt: "chocolatey"
project: false
config: true
tag: ["windows", "choco", "chocolatey"]
comments: false
---

# chocolatey
 - Windows版パッケージマネージャ
 - Macのbrewに相当する

## chocolateyの導入
 - [install](https://chocolatey.org/install)のサイトのpowershellコマンドで導入する

```console
# Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))
```

## install 

admin powershellにて、

```console
# choco install <pkg> -Y
```

## uninstall

```console
# choco uninstall <pkg>
```

## search

```console
# choco search <keyword>
```

## upgrade

```console
# choco upgrade <pkg> -Y
```
 - すでに最新版のパッケージを利用している場合はアップグレードされることはない

## upgrade all

```console
# choco upgrade all -Y
```
 - アップデートあるパッケージをインストールする
 - インストールに成功、失敗したなどのログはすべてのプロセスが完了後に表示される

## 定義したlocal_packages.configからインストールする  
 - `.config`の拡張子のxmlからまとめてソフトウェアをインストールすることができる

```console
> choco install .\local_packages.config
```

 - `local_packages.config`の内容は以下のような構造である  

```xml
<?xml version="1.0" ?>
<packages>
  <package id="7zip.install"/>
  <package id="adb"/>
  <package id="adobereader"/>
  <package id="aria2"/>
  <package id="bulk-crap-uninstaller"/>
  <package id="ccleaner"/>
  <package id="choco-package-list-backup"/>
  <package id="chocolatey"/>
  <package id="chocolatey-core.extension"/>
  <package id="chocolatey-fastanswers.extension"/>
  <package id="chocolatey-misc-helpers.extension"/>
  <package id="chocolatey-windowsupdate.extension"/>
  <package id="curl"/>
  <package id="docker-cli"/>
  <package id="docker-desktop"/>
  <package id="dotnetcore3-desktop-runtime"/>
  <package id="Firefox"/>
  <package id="git.install"/>
  <package id="GoogleChrome"/>
  <package id="jdk8"/>
  <package id="less"/>
  <package id="microsoft-windows-terminal"/>
  <package id="notepadplusplus"/>
  <package id="notepadplusplus.install"/>
  <package id="openssh"/>
  <package id="pip"/>
  <package id="powertoys"/>
  <package id="pycharm"/>
  <package id="pycharm-community"/>
  <package id="python"/>
  <package id="python3"/>
  <package id="safari"/>
  <package id="steam"/>
  <package id="vim"/>
  <package id="vivaldi"/>
  <package id="vivaldi.portable"/>
  <package id="vlc"/>
  <package id="vmwareworkstation"/>
  <package id="vscode"/>
  <package id="vscode.install"/>
  <package id="Wget"/>
  <package id="winfsp"/>
  <package id="wsl"/>
  <package id="youtube-dl"/>
  <package id="zoom"/>
  <package id="powershell-core"/>
</packages>
```

## 現在のソフトウェアのバックアップ

```console
> git clone https://github.com/NathanVaughn/choco-export
> cd choco-export
> python3 export.py
```

## トラブルシューティング

### chocolateyがハングアップして正常に機能しない
 - 原因は不明であるが、一度、chocolateyを削除して再インストールすることで回復する
 - chocolateyを削除すると何をインストールしたかなどのデータが消える
 - 再度、インストールしようと試みることで再び登録することができる
