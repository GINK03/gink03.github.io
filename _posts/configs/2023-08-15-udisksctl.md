---
layout: post
title: "udisksctl"
date: "2023-08-15"
excerpt: "udisksctlの使い方"
project: false
config: true
tag: ["udisks2", "udisksctl", "linux"]
comments: false
sort_key: "2023-08-15"
update_dates: ["2023-08-15"]
---

# udisksctlの使い方

## 概要
 - `udisk2`のパッケージに含まれるディスクマウント・アンマウントツール
 - `mount`コマンドよりモダンな作りらしい
   - ユーザが自身の権限でデバイスをマウントできる
   - 電源のoffしてからの取り外しなどのUSBフラッシュメモリ的なもののユースケースも想定されている
 - `/media/<username>/<label-or-UUID>`で自動でマウントポイントが作成される
   - 一般的にUUIDは非常に長いのでlabelを設定しておくのが望ましい
 - `polkit`(PolicyKit)で管理されており、パスワードレスでマウントするなどができる

## コマンドの例
 - ブロックデバイスのマウント
   - `$ udisksctl mount -b /dev/sdX`
 - ブロックデバイスのアンマウント
   - `$ udisksctl unmount -b /dev/sdX`
 - 接続されているディスクの確認
   - `$ udisksctl status`
   - `$ udisksctl dump | less`

## udisks2をインストールする
 - debian系
   - `$ sudo apt install udisks2`
 
## polkitのポリシーをアップデートしてパスワードレスにする

```console
# cat > /etc/polkit-1/rules.d/10-udisks2-nopasswd.rules
polkit.addRule(function(action, subject) {
    if (action.id == "org.freedesktop.udisks2.filesystem-mount-system" ||
        action.id == "org.freedesktop.udisks2.filesystem-mount") {
        return polkit.Result.YES;
    }
});
# systemctl restart polkit
```

## 各フォーマットのlabelを設定するコマンド
 - `ext4`
   - `$ sudo e2label /dev/sda <label>`
 - `btrfs`
   - `$ sudo btrfs filesystem label /dev/sda <label>`
 - `xfs`
   - `$ sudo xfs_admin -L <label> /dev/sda`
 - `ntfs`
   - `$ sudo ntfslabel /dev/sda1 <label>`

