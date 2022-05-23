---
layout: post
title: "pythonでのwarnings"
date: "2022-05-17"
excerpt: "pythonでのwarningsの扱い方"
project: false
config: true
tag: ["python", "warnings"]
comments: false
sort_key: "2022-05-17"
update_dates: ["2022-05-17"]
---

# pythonでのwarningsの扱い方

## 概要
 - `deprecated`になった機能や望ましくない使い方をするとwarningsが出ることがある
 - jupyterで出ると面倒なことがあり、コントロールが必要なことがある

## warningsをフィルタ

### すべてのwarningsを止める

```python
import warnings
warnings.filterwarnings("ignore")
```

### deprecatedに関してのみwarningsを止める

```python
import warnings
warnings.filterwarnings("ignore", category=DeprecationWarning) 
```
 - category名は送出されたwarningsのprefixを確認することで判別できる

### フィルタのアクション
 - `default`
   - モジュールと行番号につき一回だけ表示
 - `error`
   - exceptionに限定して表示
 - `ignore`
   - 常に非表示
 - `always`
   - 常に表示
 - `module`
   - moduleにつき、一回だけ表示
 - `once`
   - 一度だけ表示

## warningsを送出する
### 匿名で送出する

```python
import warnings
warnings.warn('you are warned!')
# <stdin>:1: UserWarning: you are warned!
```

### カテゴリ名をつけて送出する

```python
import warnings
warnings.warn("deprecated", DeprecationWarning)
# <stdin>:1: DeprecationWarning: deprecated
```

## 参考
 - [warnings — Warning control/Python Doc](https://docs.python.org/3/library/warnings.html)
