---
layout: post
title: "vimのpythonバインディング"
date: 2022-01-23
excerpt: "vimのpythonバインディングについて"
project: false
config: true
tag: ["python", "vim", "neovim"]
comments: false
---

# vimのpythonバインディングについて

## 概要
 - vim(neovim含む)はpythonとデフォルトでバインディング可能である
 - そこそこ早く動作するのでvimscriptやluaが書きにくい時は使用すると生産性が高い
 - 網羅的なドキュメントが存在しないので`:h py`としてヘルプを参照するのが最も正確で網羅性がある

## 関数の作り方

```vimscript
function! AnyFunctionName()
py3 << EOF
# 任意のpythonスクリプト
EOF
endfunction
```

## pythonからvim機能の呼び出し

```python
vim.command("<any-vim-command>")
```

## pythonへvim変数の読み込み

```python
vim.eval("")
```

## current windowの取得
 - `current window`とは今開いて操作している(編集している)画面のことである

```python
cwindow = vim.current.window
```

## 今のカーソルの取得

```python
crow, ccol = cwindow.cursor
```

## バッファーの取得
 - バッファーとは今画面に表示されているテキスト情報である

```python
vim.current.buffer
```

---

# 具体例

## 次の特定の文字までカーソルをジャンプする関数

```vimscript
function! GotoNextParenthes()
py3 << EOF
# 行数
cwindow = vim.current.window
crow, ccol = cwindow.cursor
CHARS = {"\"", "{", "(", "[", "]", ")", "}"}
def main():
  for row, buffer in enumerate(vim.current.buffer, 1):
    if row < crow:
      continue
    col_idx = 0
    for buf_char in buffer:
      col_idx += 1
      if row == crow:
        if col_idx <= ccol+1:
          continue
      # 操作
      if buf_char in CHARS:
        vim.command(f'''call setpos(".", [0, {row}, {col_idx}, 0])''')
        return
main()
EOF
endfunction
nmap <silent> = :call GotoNextParenthes()<CR>
```
