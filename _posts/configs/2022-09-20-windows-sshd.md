---
layout: post
title: "windows sshd"
date: 2022-09-20
excerpt: "windows sshdの使い方"
tags: ["windows", "microsoft", "sshd"]
config: true
comments: false
sort_key: "2022-09-20"
update_dates: ["2022-09-20"]
---

# windows sshdの使い方

## 概要
 - windowsにsshでアクセスするにはsshdのセットアップが必要
 - 公開鍵暗号でアクセスもできる
 - microsoftアカウントでwindowsをセットアップしている場合、microsoftアカウントのパスワードがsshdのパスワードになる


## sshd設定とインストール

```console
> Add-WindowsCapability -Online -Name OpenSSH.Server
> Start-Service sshd
> Set-Service -Name sshd -StartupType 'Automatic'
> Get-NetFirewallRule -Name *ssh*
```

## デフォルトのターミナルをpowershellに変更

```console
> New-ItemProperty -Path "HKLM:\SOFTWARE\OpenSSH" -Name DefaultShell -Value "C:\Windows\System32\WindowsPowerShell\v1.0\powershell.ex
e" -PropertyType String -Force
```

## sshdの設定
### ~/.ssh/authorized_keysを有効にし、公開鍵暗号でログインを許可する
 - デフォルトでは読み込まないように設定されている
 - `C:\ProgramData\ssh\sshd_config`の最後の二行をコメントアウト

```config
#Match Group administrators
#       AuthorizedKeysFile __PROGRAMDATA__/ssh/administrators_authorized_keys
```

## ssh上で管理者権限になる

**powershellを用いる方法**
```console
# 管理者のpowershellを起動
> powershell
> Start-Process powershell -Verb runas
# 管理者であるかをチェック
> $currentPrincipal = New-Object Security.Principal.WindowsPrincipal([Security.Principal.WindowsIdentity]::GetCurrent())
> $currentPrincipal.IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)
True
```

**sudoを用いる方法**
```console
> scoop install sudo
```
