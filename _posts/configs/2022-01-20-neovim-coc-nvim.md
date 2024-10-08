---
layout: post
title: "coc.nvim"
date: 2022-01-20
excerpt: "coc.nvimの使い方"
project: false
config: true
tag: ["coc.nvim", "nvim", "vim", "vscode"]
comments: false
sort_key: "2022-05-19"
update_dates: ["2022-05-19","2022-02-02","2022-01-25","2022-01-20"]
---

# coc.nvimの使い方

## 概要
 - nvimのtypescriptをバックエンドとして通信するプラグイン
 - vscodeの多くの資産を活用可能らしく、ユーザ数も多く、補完とエラー表示に関してはaleやvim-lspよりも安定する
   - e.g) vscodeのpyrightのneovim移植が[coc-pyright](https://github.com/fannheyward/coc-pyright)

## NOTE
 - 2022-01-25
   - `coc-pyright`がbrokenであるため、`coc-jedi`が代替になる

## インストール

**nodejsのインストール**  
```console
$ curl -sL install-node.vercel.app/lts | sudo bash
```

**nodeからyarnのインストール**
```console
$ sudo corepack enable
```

**yarn経由で手動で`coc.nvim`をビルド&インストール**
```console
$ cd ~/.config/nvim/plugged/coc.nvim
$ yarn install
```

**vim pluginのインストール**  
```vimscript
Plug 'neoclide/coc.nvim', {'branch': 'release'}
```

## 動作の確認

```vimscript
:CocInfo
```

## 各種language-serverのインストール

**jedi-language-serverの場合**  
```console
$ python3 -m pip install jedi-language-server
```

## 設定

### init.vim

**vimscript部分**  
```vimscript
""" coc.nvimの設定 """
let g:coc_global_extensions = [
\            'coc-deno',
\            'coc-jedi'
\]
```

**lua部分**  
```lua
vim.g.coc_global_extensions = { 'coc-deno', 'coc-json', 'coc-yaml', 'coc-jedi' }

-- navigate diagnostic
vim.api.nvim_set_keymap('n', '[g', '<Plug>(coc-diagnostic-prev)', {noremap = false, silent = true})
vim.api.nvim_set_keymap('n', ']g', '<Plug>(coc-diagnostic-next)', {noremap = false, silent = true})


vim.api.nvim_set_keymap('n', 'gd', '<Plug>(coc-definition)', {noremap = false, silent = true})
vim.api.nvim_set_keymap('n', 'gy', '<Plug>(coc-type-definition)', {noremap = false, silent = true})
vim.api.nvim_set_keymap('n', 'gi', '<Plug>(coc-implementation)', {noremap = false, silent = true})
vim.api.nvim_set_keymap('n', 'gr', '<Plug>(coc-references)', {noremap = false, silent = true})

-- show reference
vim.api.nvim_set_keymap('n', 'H', 'lua _G.show_documentation()', {noremap = false, silent = true})

function _G.show_documentation()
  vim.fn.CocActionAsync('doHover')
end
```

### OSによって読み込むhome/coc-settings.jsonを変更する

```lua
if vim.fn.has('macunix') then
  vim.g.coc_config_home = "~/.config/nvim/coc-config-macunix"
end
```
 - binaryのpathがOSによって替わり得るので必要

### coc-settings.json

```json
{
  "pyright.enable": true,
  "pyright.disableDiagnostics": false,
  "python.linting.mypyEnabled": true,
  "jedi.enable": true,
  "jedi.startupMessage": false,
  "jedi.markupKindPreferred": "plaintext",
  "jedi.trace.server": "off",
  "jedi.jediSettings.autoImportModules": [],
  "jedi.jediSettings.caseInsensitiveCompletion": true,
  "jedi.jediSettings.debug": false,
  "jedi.executable.command": "jedi-language-server",
  "jedi.executable.args": [],
  "jedi.jediSettings.autoImportModules": ["numpy", "pandas"],
  "jedi.codeAction.nameExtractFunction": "jls_extract_def",
  "jedi.codeAction.nameExtractVariable": "jls_extract_var",
  "jedi.completion.disableSnippets": false,
  "jedi.completion.resolveEagerly": false,
  "jedi.completion.ignorePatterns": [],
  "jedi.diagnostics.enable": false,
  "jedi.diagnostics.didOpen": false,
  "jedi.diagnostics.didChange": false,
  "jedi.diagnostics.didSave": false,
  "jedi.hover.enable": true,
  "jedi.hover.disable.keyword.all": false,
  "jedi.hover.disable.keyword.names": [],
  "jedi.hover.disable.keyword.fullNames": [],
  "jedi.workspace.extraPaths": [],
  "jedi.workspace.symbols.maxSymbols": 20,
  "jedi.workspace.symbols.ignoreFolders": [
    ".nox",
    ".tox",
    ".venv",
    "__pycache__",
    "venv"
  ]
}
```

---

## トラブルシューティング

### `Connection to server got closed. Server will restart.`と表示されてcocが開始しない
 - 原因
   - language-serverが壊れている or インストールされていない
 - 対応
   - language-serverの再インストール
 - 参考
   - [Connection to server got closed. Server will restart. #2199](https://github.com/neoclide/coc.nvim/issues/2199)

### pumvisible(補完の決定)がうまく動作しない
 - 原因
   - `coc#pum#visible() ? coc#_select_confirm() : coc#refresh()`のような専用の関数が用意されている
 - 対応
   - `Ctrl+y`で決定できる
   - `inoremap <expr> å coc#pum#visible() ? coc#_select_confirm() : coc#refresh()`のようなvimrcの定義を行う
 - 参考
   - [can't change completion key trying to switch it to tab #4008](https://github.com/neoclide/coc.nvim/issues/4008)

### nodeのlanguage serverのメモリ消費量が異常なことになり、OSがハングアップする
 - 原因
   - ファイル名の補完などのために、大量のファイルをスキャンしている可能性がある
   - tweet収集基盤などでファイルが多すぎてハングアップした
 - 対応
   - 大量のファイルをスキャンするようなファイルパス・ディレクトリで`coc-nvim`を使用しない

### 最新のnodejsを使用しているのに、クラッシュしたり、動作が安定しない
 - 原因
   - aptなどの管理のnodejsと手動で導入したnodejsの2つ以上あり、不整合を起こしている
 - 対応
   - aptのnodejsをアンイストール
