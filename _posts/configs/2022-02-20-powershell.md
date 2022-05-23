---
layout: post
title: "powershell"
date: 2022-02-20
excerpt: "powershellの使い方"
project: false
config: true
tag: ["shell", "windows", "powershell"]
comments: false
sort_key: "2022-05-02"
update_dates: ["2022-05-02","2022-02-21","2022-02-20"]
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

### パッケージをpowershell経由でアンインストールする

**アプリケーション一覧を得る**  
```console
> Get-WmiObject -Class Win32_Product | Select-Object -Property Name
```
 - powershell経由で操作可能なパッケージ一覧が得られる

**アプリケーション名を指定してアンインストール**  
```console
> Get-Package  -Name "VNC Server 6.8.0" | Uninstall-Package
```

 - 参考
   - [How to Uninstall Software Using PowerShell](https://techgenix.com/how-to-uninstall-software-using-powershell/)


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
