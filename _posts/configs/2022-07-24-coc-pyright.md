---
layout: post
title: "coc-pyright"
date: 2022-07-24
excerpt: "coc-pyrightの使い方"
config: true
tag: ["coc.nvim", "nvim", "vim", "vscode", "pyright"]
comments: false
sort_key: "2022-05-19"
update_dates: ["2022-05-19","2022-02-02","2022-01-25","2022-01-20"]
---

# coc-pyrightの使い方

## 概要
 - microsoftのvscodeのpython用のlanguage serverのpyrightをcoc-neovimに移植したもの
 - cocのlanguage serverは小さいプロジェクトが散在している状態なので、いつサポートが切れるかわかない
 - 型情報の不備をチェックすることができる

## coc-setting.json
 - 利用していない変数を警告しない
 - stubがインポートされているpythonのpath

```json
{
  "diagnostic.showUnused": false,
  "python.pythonPath": "<path-to-python>",
  ...
}
```

---

## トラブルシューティング

### `:CocInfo`など確認しても問題がないが、動作していないように見える
 - 原因
   - `coc-config.json`などが原因で動作しなくなっている
 - 対応
   - `coc-config.json`を修正するか、無効化する

---

## 参考
 - [fannheyward/coc-pyright](https://github.com/fannheyward/coc-pyright)
   - 詳細な仕様はissueを掘る


