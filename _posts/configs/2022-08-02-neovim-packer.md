---
layout: post
title: "neovim packer"
date: "2022-08-02"
excerpt: "neovimでのpacker.nvimの使い方"
config: true
tag: ["neovim", "lua", "luajit", "packer.nvim"]
comments: false
sort_key: "2022-08-02"
update_dates: ["2022-08-02"]
---

# neovimでのpacker.nvimの使い方

## 概要
 - neovim専用のパッケージマネージャ(vimでは動作しない)
 - `:PakcerSync`ではgithubのコミットハッシュを監視しているので、force pushされたレポジトリがあるとエラーになる

## インストール

```console
$ git clone --depth 1 https://github.com/wbthomason/packer.nvim ~/.local/share/nvim/site/pack/packer/start/packer.nvim
```
 - `init.vim`にブートストラップを記述できる

## パッケージの追加

```vimscript
return require('packer').startup(function(use)
  -- packer自身
  use 'wbthomason/packer.nvim'
  -- vim-plug
  use 'junegunn/vim-plug'
end)
```
 - `use`のあとにgithubの管理レポジトリを記述する

## 基本操作
 - `:PackerClean`
   - 使用していないプラグインを削除
 - `:PackerInstall`
   - 不足しているプラグインをインストール
 - `:PackerUpdate`
   - アップデートしてインストール
 - `:PackerSync`
   - `:PackerUpdate`して`:PackerCompile`する

## 一時的にプラグインを無効化する
 - 無効化したいプラグインの`use`に`disable = true`を追加する
 - `disable = true` を追加したプラグインは `:PackerSync` で無効化される

```lua
use {
  'myusername/example',
  disable = true,
  ...
}
```

---

## トラブルシューティング

### `:PackerSync`でエラーがでてアップデートできない
 - 原因
   - 参照しているライブラリのgitがforce pushされたなどで不整合が起きた
 - 対応
   - `.local/share/nvim/site/pack/packer/<packege-name>`を削除して再度`:PackerSync`を行う

---

## 参考
 - [wbthomason/packer.nvim](https://github.com/wbthomason/packer.nvim)

