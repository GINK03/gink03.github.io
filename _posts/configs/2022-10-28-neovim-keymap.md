---
layout: post
title: "neovim keymap"
date: "2022-10-28"
excerpt: "neovim keymapの使い方"
config: true
tag: ["neovim", "lua", "luajit", "keymap"]
comments: false
sort_key: "2022-10-28"
update_dates: ["2022-10-28"]
---

# neovim keymapの使い方

## 概要
 - luaのAPI経由での設定例
 - `silent`, `expr`, `noremap`の意味
 - luaのスクリプトの呼び出しの例

## オプションの説明
 - `expr`
   - 引数にスクリプトを取ることができる
 - `noremap`
   - 再設定の禁止の明確化
 - `silent`
   - 実行したコマンドが表示されないようにする

## 具体例

### lua scriptをコマンドで呼び出す例

```lua
-- スクリプトを定義
function _G.test()
  print("test")
  return '<CR>'
end

vim.api.nvim_set_keymap(
  'n', -- ノーマルモードで
  'test', -- "test"を押すと
  'v:lua.test()', -- luascriptの呼び出し
  {expr = true, noremap = true}
)
```

### coc-nvimの候補の決定を設定する例

```lua
vim.api.nvim_set_keymap(
  'i', -- インサートモード
  'å',  -- alt + aのインプット
  'coc#pum#visible() ? coc#_select_confirm() : coc#refresh()', 
  {noremap = true, silent = false, expr = true}
)
```
