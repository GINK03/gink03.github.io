---
layout: post
title: "terminal上でjupyter + jq"
date: 2024-08-11
excerpt: "terminal上でjupyter + jqの使い方"
tag: ["jupyter", "kaggle", "python"]
comments: false
sort_key: "2024-08-11"
update_dates: ["2024-08-11"]
---

# terminal上でjupyter + jqの使い方

## 概要
 - jqコマンドを用いて、jupyterの`.ipynb`ファイルを(わかりやすい形で)ターミナル上で表示できる

## 使用例

```console
$ jq -r '.cells[] | .source | join("")' foo.ipynb | less
```
