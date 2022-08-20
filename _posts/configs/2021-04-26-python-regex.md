---
layout: post
title: "pythonのregex"
date: 2021-04-26
excerpt: "pythonのregex使い方"
config: true
tag: ["python", "library", "regex"]
comments: false
sort_key: "2022-01-19"
update_dates: ["2022-01-19","2021-10-20","2021-08-06","2021-04-26"]
---

# pythonのregex

## 概要
 - Alternative regular expression module, to replace re.
 - pythonのライブラリでJavaなどでサポートされている高機能な正規表現が使える
 - `pcre`という正規表現の基準を満たしており、ドキュメントに記されていない方法であっても`pcre`がサポートしている場合、使えることがある
   - https://mariadb.com/kb/en/pcre/

## インストール

```console
$ python3 -m pip install regex
```

## 使用の具体例

### ひらがな検索

```python
>>> regex.search("\p{Hiragana}{1,}", "ハロー,你好,こんにちは")
<regex.Match object; span=(7, 12), match='こんにちは'>
```

### カタカナ検索

```python
>>> regex.search("\p{Katakana}{1,}", "ハロー,你好,こんにちは")
<regex.Match object; span=(0, 2), match='ハロ'>
```

### 漢字検索

```python
>>> regex.search("\p{Han}{1,}", "ハロー,你好,こんにちは")
<regex.Match object; span=(4, 6), match='你好'>
```

### ハングル

```python
>>> regex.match("\p{Hangul}{1,}", "방탄소년단")
<regex.Match object; span=(0, 5), match='방탄소년단'>
```

### アラビア語

```python
>>> regex.match("\p{Arabic}{1,}", "مرحبا")
<regex.Match object; span=(0, 5), match='ﻡﺮﺤﺑﺍ'>
```

---

## 参考
 - [Alternative regular expression module, to replace re./pypi](https://pypi.org/project/regex/)
