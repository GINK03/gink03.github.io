---
layout: post
title: "nix home-manager"
date: 2024-01-09
excerpt: "nix home-managerの使い方"
tags: ["nix", "nixpkgs", "macos", "linux", "nix", "package manager"]
config: true
comments: false
sort_key: "2024-01-09"
update_dates: ["2024-01-09"]
---

# nix home-managerの使い方

## 概要
 - nixがインストールされていることが前提
 - dotfilesを管理するためのツール
 - ファイルへのシンボリックリンクを貼るだけでなく、nixpkgsのパッケージをインストールすることもできる

## インストール

```console
$ nix-channel --add https://github.com/nix-community/home-manager/archive/master.tar.gz home-manager
$ nix-channel --update
$ nix-shell '<home-manager>' -A install
```

## 設定ファイルのパス
 - `~/.config/home-manager/home.nix`

## 基本的なコマンド
 - `home-manager switch`
   - 設定ファイルを反映
 - `home-manager edit`
   - 設定ファイルを編集
 - `home-manager build`
   - 設定ファイルをビルド
 - `home-manager generation`
   - 設定ファイルの履歴を確認
 - `home-manager packages`
   - インストールされているパッケージを確認

## パッケージのアップデート

```console
$ nix-channel --update
$ home-manager switch
```

## 作成した設定ファイル
 - [home.nix](https://bitbucket.org/nardtree/gimpei-dot-files/src/master/files/home-manager/home.nix)

## systemdのサービスを設定
 - `home.nix`に以下を追加
 - `systemctl --user enable home-manager-service`で有効化

```nix
# systemd servicesを設定する例
systemd.user.services.home-manager-service = {
  Unit = {
    Description = "systemd service ";
    After = [ "network.target" ];
  };
  Install = {
    WantedBy = [ "default.target" ];
  };
  Service = {
    Type = "simple";
    ExecStart = "${pkgs.writeShellScript "home-manager-service" ''
      #!/bin/sh
      echo 1
    ''}";
    Restart = "always";
    RestartSec = 5;
  };
};
```

## トラブルシューティング

### `warning: setlocale: LC_ALL: cannot change locale (en_US.UTF-8)`と都度出る
 - 原因
   - `nix-shell -p glibcLocales`実行で再現
 - 対応
   - `LC_ALL`をunsetする
   - `~/.nixpkgs/config.nix`に以下を追加する

```nix
{
  packageOverrides = pkgs: {
    myLocaleSettings = pkgs.lib.overrideDerivation pkgs.glibc (oldAttrs: {
      LOCALE_ARCHIVE = pkgs.lib.fileContents "/usr/lib/locale/locale-archive";
    });
  };
}
```
 - 参考
   - [Can"t solve 'setlocale: LC_ALL: cannot change locale' Issues on Nix running on Ubuntu](https://www.reddit.com/r/Nix/comments/18xjscn/cant_solve_setlocale_lc_all_cannot_change_locale/)
   - [#90523](https://github.com/NixOS/nixpkgs/issues/90523)
   - [nix-shell cannot change locale warning](https://stackoverflow.com/questions/62287269/nix-shell-cannot-change-locale-warning)
