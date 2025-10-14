---
layout: post
title: "neovim tree-sitter"
date: "2022-10-27"
excerpt: "neovim tree-sitterの使い方"
config: true
tag: ["neovim", "lua", "luajit", "tree-sitter"]
comments: false
sort_key: "2022-10-27"
update_dates: ["2022-10-27"]
---

# neovim tree-sitterの使い方

## 概要
 - 高精度の構文解析に基づくシンタックスハイライトと自動インデント
 - 各言語ごとにパーサーのバイナリをインストールが必要
 - 色が崩れたと感じたら `:TSInstall all` や `:TSUpdate` を実行

## 各言語のパーサーをインストール

```console
:TSInstall all
```

## npmパッケージのインストール

```console
$ sudo npm install -g tree-sitter-cli
```

## 初期設定（tree-sitter CLI）
 - CLI の初期設定を実行し、ユーザー設定を作成

```console
$ tree-sitter init-config
```

## 設定の具体例

```lua
print('start to load init-treesitter.lua.')

require("nvim-treesitter.configs").setup({
  ensure_installed = { "python", "markdown", "lua", "rust" },
  sync_install = false,     -- 同期インストールしない（デフォルト）
  auto_install = true,      -- 未インストール言語を自動インストール
  ignore_install = { "javascript" },
  highlight = {
    enable = true,
    -- 大きいファイルや特定言語で無効化
    disable = function(lang, buf)
      if lang == "ruby" then return true end
      local max_filesize = 500 * 1024 -- 500KB
      local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
      if ok and stats and stats.size > max_filesize then
        return true
      end
    end,
    additional_vim_regex_highlighting = false,
  },
  indent = { enable = true },
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
