---
layout: post
title: "vim-easy-align"
date: "2023-07-08"
excerpt: "vim-easy-alignの扱い方"
project: false
config: true
tag: ["neovim", "vim", "vim-easy-align", "markdown"]
comments: false
sort_key: "2023-07-08"
update_dates: ["2023-07-08"]
---

# vim-easy-alignの扱い方

## 概要
 - markdownの表のセパレータ`|`やプログラム言語の`=`で整列することができる

## インストール

**plug**
```vim
Plug 'junegunn/vim-easy-align'
```

### マークダウンの表の整列

```markdown
|   c0 | c1  | c2   |
|   a0 | a1  | aaa  |
| cccc | cc  | cccc |
|    c | ddd | cc   |
```

 - `gaip*|`
   - 左寄せ
 - `gaip**|`
   - 左寄せ(一部右になる)
 - `gaip**2|`
   - 二番目の|に対して右寄せる
 - `gaip ↵ -|`
   - 右端の列だげ右寄せ
 - `gaip ↵ 2|`
   - 3番目のデリミタの共起
 - `gaip^P|`
   - ライブモードになる

### コード

```python
apple  = red
grass += green
sky   -= blue
```

 - `gaip*=` 
   - イコールをもとに整列することができる

### yamlの整列 

```yaml
setting:
  ip:    ["192.168.1.10", "192.168.2.10"]
  dns:   "1.1.1.1"
```
 
 - `visual modeで選択` + `ga*:`
