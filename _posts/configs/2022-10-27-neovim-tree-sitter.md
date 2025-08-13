---
layout: post
title: "neovim tree-sitter"
date: "2022-10-27"
excerpt: "neovim tree-sitterの使い方"
config: true
tags: ["neovim", "lua", "luajit", "tree-sitter"]
comments: false
sort_key: "2022-10-27"
update_dates: ["2022-10-27"]
---

# neovim tree-sitterの使い方

## 概要
 - より高級なパーサーを利用してのシンタックスハイライト、オートインデント
 - 各言語ごとにパーサーのバイナリをインストールする必要がある
 - インストールされていない言語があったとしても警告等は出ないので、色が変だと感じたら`TSInstall all`するとよい

## 各言語のパーサーをインストール

```console
:TSInstall all
```

## npmパッケージのインストール

```console
$ sudo npm install -g tree-sitter-cli
```

## 設定の具体例

```lua
print('start to load init-treesitter.lua.')

require("nvim-treesitter.configs").setup({
  ensure_installed = { "python", "markdown", "lua", "rust" },
  sync_install = false, -- デフォルト
  auto_install = true, -- 自動インストール
  ignore_install = { "javascript" },
  highlight = {
    enable = true,              -- false will disable the whole extension
    disable = { "ruby" },  -- list of language that will be disabled
  },
  indent = {
    enable = true
  },
  -- 大きいファイルのときは無効化
  disable = function(lang, buf)
    local max_filesize = 5 * 100 * 1024 -- 500 KB
    local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
    if ok and stats and stats.size > max_filesize then
      return true
    end
  end,
  -- additional_vim_regex_highlighting = false,
})
```

---

## トラブルシューティング

### エラーが消えない時
 - 原因
   - バージョンアップに伴う不整合
 - 対応
   - 一度パッケージを完全に削除してから、再インストール
     - plugであれば、~/.config/nvim/plugged/から削除し再インストール
 - 参考
   - [Highlights broken after update with `query: invalid node type` #3092](https://github.com/nvim-treesitter/nvim-treesitter/issues/3092)
   - 一度パッケージを完全に削除してから、再インストール
