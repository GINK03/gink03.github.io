---
layout: post
title: "python platform" 
date: "2022-09-27"
excerpt: "python platformの使い方"
config: true
tag: ["platform", "python"]
comments: false
sort_key: "2022-09-27"
update_dates: ["2022-09-27"]
---

# python platfromの使い方

## 概要
 - python標準のOS, CPUのアーキテクチャを簡便に判定するモジュール
 - `macOS`と`Linux`, `arm`と`x86_64`で処理を分岐する必要があるときがユースケース

## 具体例
 - mecabの辞書ファイルはos, cpuでパスが異なる
 - match caseとplatformモジュールで対応可能

```python
match (platform.system(), platform.processor()):
    case ("Darwin", "arm"):
        parser = MeCab.Tagger("-Owakati -d /opt/homebrew/lib/mecab/dic/mecab-ipadic-neologd/")
    case ("Linux", "x86_64"):
        parser = MeCab.Tagger("-Owakati -d /usr/lib/x86_64-linux-gnu/mecab/dic/mecab-ipadic-neologd/")
    case ("Linux", "aarch64"):
        parser = MeCab.Tagger("-Owakati -d /usr/lib/aarch64-linux-gnu/mecab/dic/mecab-ipadic-neologd/")
    case _:
        raise Exception("サポート外のアーキテクチャです")
```

---

## 参考
 - [platform --- 実行中プラットフォームの固有情報を参照する/python.org](https://docs.python.org/ja/3/library/platform.html)
