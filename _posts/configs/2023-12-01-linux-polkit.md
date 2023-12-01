---
layout: post
title: "linux polkit"
date: 2023-12-01
excerpt: "linuxのpolkitについて"
config: true
tag: ["linux", "polkit"]
comments: false
sort_key: "2023-12-01"
update_dates: ["2023-12-01"]
---

# linuxのpolkitについて

## 概要
 - polkitはunix系のOSで非特権ユーザが部分的に特権を行うためのフレームワーク

## 基本的な用語
 - アクション
   - 特権を行うため行動
 - ポリシー
   - アクションに対する許可・非許可
 - エージェント
   - ポリシーに従ってユーザに対してアクションを行う

## コンポーネント
 - polkitd
   - デーモン
 - polkit-agent
   - GUI, CUIでユーザ認証を行う
   - 専用のパッケージが存在し、 `polkit-gnome-authentication-agent` や `lxpolkit` などがある
 - `.rules` ファイル
   - ポリシーを記述する
   - `/etc/polkit-1/rules.d/` に配置されるJavaScriptで記述されたファイル

## インストール
 - GUIがないdebianではインストール後に再起動が必要であった

**ubuntu, debian**
```console
$ sudo apt-get install policykit-1
$ sudo apt-get install policykit-1-gnome # 認証エージェント
```

## 設定例

### ディスクのマウント
 - [udisksctl](/udisksctl/)でマウント可能になる

**/etc/polkit-1/rules.d/10-mount.rules**
```
polkit.addRule(function(action, subject) {
    if (action.id == "org.freedesktop.udisks2.filesystem-mount-system" ||
        action.id == "org.freedesktop.udisks2.filesystem-mount") {
        if (subject.isInGroup("storage")) {
            return polkit.Result.YES;
        }
    }
});
```

