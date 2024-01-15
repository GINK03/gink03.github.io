---
layout: post
title: "nix flake develop"
date: 2024-01-15
excerpt: "nix flake developついて"
tags: ["nix", "nixpkgs", "macos", "linux", "nix", "package manager"]
config: true
comments: false
sort_key: "2024-01-15"
update_dates: ["2024-01-15"]
---

# nix flake developについて

## 概要
 - nix flake developはnix flakeの一機能
 - nix-shellの代替
 - ソフトウェアの開発環境を構築するためのnix flakeの機能

## nix flake developの使い方
 - プロジェクトのルートディレクトリに`flake.nix`を作成する

```nix
{
  description = "A simple Python project";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
    mach-nix.url = "github:davhau/mach-nix";
  };

  outputs = { self, nixpkgs, flake-utils, mach-nix, ... }:
  let
    pythonVersion = "python39";
  in
  flake-utils.lib.eachDefaultSystem (system:
    let
      pkgs = nixpkgs.legacyPackages.${system};
      glibcLocales = pkgs.glibcLocales;
      mach = mach-nix.lib.${system};

      pythonEnv = mach.mkPython {
        python = pythonVersion;
        # requirements = builtins.readFile ./requirements.txt;
        requirements = ''
          numpy
          pandas
          matplotlib
          seaborn
          jupyterlab
        '';
      };
    in
    {
      devShells.default = pkgs.mkShell {
        packages = [
          pythonEnv
          pkgs.glibcLocales
          pkgs.vim
          pkgs.git
          pkgs.gcc
        ];
        LOCALE_ARCHIVE = "${glibcLocales}/lib/locale/locale-archive";
        shellHook = ''
          export PYTHONPATH="${pythonEnv}/bin/python"
        '';
      };
    }
  );
}
```
