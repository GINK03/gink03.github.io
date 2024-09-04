---
layout: post
title: "BPE(Byte Pair Encoding)"
date: 2024-09-04
excerpt: "BPE(Byte Pair Encoding)について"
computer_science: true
tag: ["algorithm", "data structure", "BPE"]
comments: false
sort_key: "2024-09-04"
update_dates: ["2020-09-04"]
---

# BPE(Byte Pair Encoding)について

## 概要
 - BPEは、テキストデータの圧縮アルゴリズムの一つ
 - ディープラーニングでの自然言語処理の前処理やトークン分割で使われることがある

## アルゴリズム
 1. テキストデータ中の文字のペアをカウント
 2. 最も多く出現する文字のペアをマージ
 3. 1, 2を繰り返す

## キャラクターベースでの実装例

```python
import re
import collections
import pandas as pd
from tqdm.auto import tqdm

# テキストデータの読み込み
default_text = "..." # テキストデータを入力

text = " ".join(list(default_text))
                                   
def function(text):
    pairs = collections.defaultdict(int)
    chars = text.split(" ")
    for i in range(len(chars)-1):
        pairs[chars[i], chars[i+1]] += 1
    best_key = max(pairs, key=pairs.get)
    if pairs[best_key] <= 1:
        return text, False
    text = text.replace(f"{best_key[0]} {best_key[1]}", f"{best_key[0]}{best_key[1]}")
    return text, True

for i in tqdm(range(10000)):
    text, can_continue = function(text)
    if can_continue == False:
        break

print(text[:1000])
```

**銀河鉄道の夜*BPEで処理した結果の一部**

```
「ではみなさんは、 そう いう ふう に川 だと云われたり、 乳の 流れた あと だと云われたり していた このぼんやりと白い ものが ほんとう は何か ご 承 知 ですか。」 
先生は、 黒 板 に 吊 した 大きな 黒い星座 の図 の、 上から下 へ 白く け ぶった 銀河 帯 のような ところ を指 しながら、 みんな に 問 をかけ ました。
 カムパネルラが 手をあげました。 それから 四五 人 手をあげました。ジョバンニも 手をあげ ようと して、 急いで そのまま や め ました。 たしかにあれ がみんな星だと、 いつか 雑誌 で 読んだので したが、 このごろ は ジョバンニはまるで 毎日 教室 でも ねむ く、 本を 読む ひ ま も 読む 本もないので、 なんだか どんな ことも よく わからない という 気持ちが するのでした。
　 ところが 先生は 早く も それを見附 けたのでした。
```

## 参考
 - [BPE(Byte Pair Encoding)アルゴリズムの仕組みとPythonプログラムの確認](https://www.hello-statisticians.com/ml/nlp/bpe1.html)
