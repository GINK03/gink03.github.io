---
layout: post
title: "powershell"
date: 2022-02-20
excerpt: "powershellの使い方"
config: true
tag: ["shell", "windows", "powershell", "coreutils"]
comments: false
sort_key: "2022-05-02"
update_dates: ["2022-05-02","2022-02-21","2022-02-20"]
---

# powershellの使い方

## 概要
 - コマンドプロンプトの代わりに作成されたwindowsのシェル
 - linuxやmacosxでも一応動くとされている
 - `Foo-Bar`のようなキャメルケースでコマンドが定義されている
   - linuxのようなコマンドがいくつかエイリアスされている

## インストール

```console
> choco install powershell-core
```

## 基本的な使い方

### GNU Linuxと似たコマンドをインストール

```console
> scoop install 7zip curl sudo git openssh
```

```console
> cargo install coreutils
```
 - rustで記述されたジェネリックなcoreutils

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

### シンボリックリンクの作成
 - シンボリックリンクはフルパスで記述されておく必要がある
 - `-Target <実態があるパス>`
 - `-Path <作成するシンボリックリンクのパス>`

**具体例(OneDriveの中にあるデスクトップフォルダを, 英語の名前でシンボリックリンクを作成する)**
```console
> New-Item -ItemType Junction -Target "$PWD\OneDrive\デスクトップ" -Path "$PWD\Desktop"
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

### powershellのバージョンの確認

```console
> echo $PSversionTable
Name                           Value
----                           -----
PSVersion                      7.2.5
PSEdition                      Core
GitCommitId                    7.2.5
OS                             Microsoft Windows 10.0.22610
Platform                       Win32NT
PSCompatibleVersions           {1.0, 2.0, 3.0, 4.0…}
PSRemotingProtocolVersion      2.3
SerializationVersion           1.1.0.1
WSManStackVersion              3.0
```

### powershellのアップグレード
 - chocolateyなどを利用
   - `> choco install pwsh`
 - sshした際に起動するシェルはレジストリで定義されている
   - 単純に最新のpowershellを入れただけでは反映されない
 - 参考
   - [OpenSSH : デフォルトシェルを変更する](https://www.server-world.info/query?os=Windows_Server_2019&p=ssh&f=5)


### ホストの再起動

```console
> Restart-Computer
```

### プロファイルをリロード

```console
> . $PROFILE
```

## 発展

### starshipをインストールしてprofileを設定

```console
> scoop install starship neovim
> echo $PROFILE # .bashrc, .zshrcに相当するパスを確認
> nvim $PROFILE
```
以下の内容を書き込む

```shell
Invoke-Expression (&starship init powershell)

# Remove-Alias ls
Set-Alias ls lsd
Set-Alias b bat
Remove-Alias cp
function cp { coreutils cp $args }
function ll { coreutils ls $args }
function df { coreutils df $args }
function date { coreutils date $args }
```

## 参考
 - [PowerShell入門](https://life-is-command.com/powershell-beginner/)
 - [WindowsのTerminal環境を整えたい](https://www.natsuneko.blog/entry/2020/08/01/windows-terminal-environment)
