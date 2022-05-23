---
layout: post
title: "python pdb"
date: "2022-05-20"
excerpt: "python pdbの使い方"
project: false
config: true
tag: ["python", "pdb"]
comments: false
sort_key: "2022-05-20"
update_dates: ["2022-05-20"]
---

# python pdbの使い方

## 概要
 - デバック用のブレークポイントを挿入できるライブラリ
 - `pdb.set_trace()`を仕込むことで一時停止して周辺の変数の様子を知ることができる
 - `python3 -m pdb myscript.py`として例外で落ちる箇所を特定することもできる

## pdbのコマンド
 - `h`
   - ヘルプ
 - `w`
   - スタックトレースを表示
 - `l`
   - 周辺のコードを表示
 - `p <変数名>`
   - 変数名の中身を表示
 - `pp <変数名>`
   - 変数名のpretty print
 - `c`
   - 次のbreak pointまで続ける
 - `u`
   - スタックを１つ上に戻す

## 具体例

```python
import pdb

def sample():
    imps = "bar"   
    pdb.set_trace()
    return imps

def main():
    sample()

if __name__ == "__main__":
    main()
```

```console
$ python3 sample-pdb.py
-> return imps
(Pdb) w
-> main()
-> sample()
-> return imps
(Pdb) p
*** SyntaxError: invalid syntax
(Pdb) l
  2     import sys
  3  
  4     def sample():
  5         imps = "bar"
  6         pdb.set_trace()
  7  ->     return imps
  8     
  9     def main():
 10         sample()
 11     
 12     if __name__ == "__main__":
(Pdb) p imps
'bar'   
(Pdb) c
```

## 参考
 - [pdb — The Python Debugger](https://docs.python.org/3/library/pdb.html)
