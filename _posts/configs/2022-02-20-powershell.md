---
layout: post
title: "powershell"
date: 2022-02-20
excerpt: "powershellの使い方"
project: false
config: true
tag: ["shell", "windows", "powershell"]
comments: false
---

# powershellの使い方

## 概要
 - コマンドプロンプトの代わりに作成されたwindowsのシェル
 - linuxやmacosxでも一応動くとされている
 - `Foo-Bar`のような表示でコマンドが定義されている
   - linuxのようなコマンドがいくつかエイリアスされている

## 基本的な使い方

### GNU Linuxと似たコマンドをインストール

```console
> scoop install 7zip curl sudo git openssh coreutils grep sed less
```

### aliasの確認

```console
> Get-Alias
CommandType     Name                                               Version    Source
-----------     ----                                               -------    ------
Alias           % -> ForEach-Object
Alias           ? -> Where-Object
Alias           ac -> Add-Content
Alias           cat -> Get-Content
Alias           cd -> Set-Location
Alias           CFS -> ConvertFrom-String                          3.1.0.0    Microsoft.PowerShell.Utility
Alias           chdir -> Set-Location
Alias           clc -> Clear-Content
Alias           clear -> Clear-Host
...
```

### ページャー
 - インストールされたlessは日本語が正常に表示されない
 - 以下のコマンドで代替できる

```console
> cat *.csv | Out-Host –Paging
```

### NetIPConfiguration
 - ipアドレスの操作関連

**IPアドレスとインターフェースインデックスの確認**  
```console
> Get-NetIPConfiguration
```

**IPアドレスをセットする**  
 - `192.168.40.16/24`をインターフェースインデックス`23`に追加する例

```console
> New-NetIPAddress -InterfaceIndex 23 -IPAddress 192.168.40.16 -PrefixLength 24
```

## 発展

### starshipをインストール

```console
> scoop install starship vim
> echo $PROFILE # .bashrc, .zshrcに相当するパスを確認
> vim $PROFILE
```
以下の内容を書き込む

```shell
Invoke-Expression (&starship init powershell)
```

## 参考
 - [PowerShell入門](https://life-is-command.com/powershell-beginner/)