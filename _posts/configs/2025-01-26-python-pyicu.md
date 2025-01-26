---
layout: post
title: "python pyicu"
date: 2025-01-24
excerpt: "python pyicuの使い方"
config: true
tag: ["python", "pyicu", "icu", "形態素解析"]
comments: false
sort_key: "2025-01-24"
update_dates: ["2025-01-24"]
---

# python pyicuの使い方

## 概要
 - pythonからICUを利用するためのラッパーライブラリ

## インストール

**debian**
```console
$ sudo apt install libicu-dev pkg-config
```

```console
$ pip install pyicu
```

## 使い方

**センテンス単位で分割**

```python
from typing import List
from icu import BreakIterator, Locale
def split_into_sentences(text: str) -> List[str]:
    """BreakIterator を使って日本語テキストを文単位に分割する。"""
    brk = BreakIterator.createSentenceInstance(Locale("ja"))
    brk.setText(text)
    sentences = []
    start = brk.first()
    
    for end in brk:
        sentence = text[start:end].strip()
        if sentence:
            sentences.append(sentence)
        start = end
    
    return sentences

text = """親譲りの無鉄砲で小供の時から損ばかりしている。小学校に居る時分学校の二階から飛び降りて一週間ほど腰を抜かした事がある。なぜそんな無闇をしたと聞く人があるかも知れぬ。別段深い理由でもない。新築の二階から首を出していたら、同級生の一人が冗談に、いくら威張っても、そこから飛び降りる事は出来まい。弱虫やーい。と囃したからである。小使に負ぶさって帰って来た時、おやじが大きな眼をして二階ぐらいから飛び降りて腰を抜かす奴があるかと云ったから、この次は抜かさずに飛んで見せますと答えた。"""
print(*split_into_sentences(text), sep="\n")
"""
親譲りの無鉄砲で小供の時から損ばかりしている。
小学校に居る時分学校の二階から飛び降りて一週間ほど腰を抜かした事がある。
なぜそんな無闇をしたと聞く人があるかも知れぬ。
別段深い理由でもない。
新築の二階から首を出していたら、同級生の一人が冗談に、いくら威張っても、そこから飛び降りる事は出来まい。
弱虫やーい。
と囃したからである。
小使に負ぶさって帰って来た時、おやじが大きな眼をして二階ぐらいから飛び降りて腰を抜かす奴があるかと云ったから、この次は抜かさずに飛んで見せますと答えた。
"""
```

**形態素解析**

```python
from typing import List
from icu import BreakIterator, Locale

def tokenize_with_icu(text: str, locale='ja') -> List[str]:
    """
    ICU の Word BreakIterator を使い、
    テキストを「単語」単位に近い形で分割する。
    
    ※ ICU に辞書データが含まれていない環境では、
      日本語が一文字ずつに分割される可能性があります。
    """
    brk = BreakIterator.createWordInstance(Locale(locale))
    brk.setText(text)

    tokens = []
    start = brk.first()
    for end in brk:
        token = text[start:end].strip()
        if token:
            tokens.append(token)
        start = end
    
    return tokens
```
