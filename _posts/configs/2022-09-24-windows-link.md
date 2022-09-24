---
layout: post
title: "windows link"
date: 2022-09-25
excerpt: "windows link(シンボリックリンク、ハードリンク)"
tags: ["windows", "microsoft", "link"]
config: true
comments: false
sort_key: "2022-09-25"
update_dates: ["2022-09-25"]
---

# windows link(シンボリックリンク、ハードリンク)

## 概要
 - powershellになってから記法が変化
 - リンクを作成したいパスと実態のパスを入れ替え可能に(linuxの表現に合わせやすい)
 - 絶対パスで記したほうが間違いが少ない

## シンボリックリンク

```console
> New-Item -ItemType SymbolicLink -Target "TargetPath" -Path "CreatePath"
```
 - "TargetPath"; 実態があるファイル・ディレクトリ
 - "CreatePath"; シンボリックリンクを作成したい先

### 具体例

```console
> touch sample.txt
> New-Item -ItemType SymbolicLink -Target "$PWD/sample.txt" -Path "$PWD/this-is-a-symboliclink.txt"
```
