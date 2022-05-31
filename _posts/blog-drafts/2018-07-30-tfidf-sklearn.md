---
layout: post
title: "tfidf (sklearn)"
date: 2018-07-30
excerpt: ""
tags: [tfidf, sklearn]
comments: false
---

# tfidf

手で計算しなくても便利なライブラリがある。

```python
from sklearn.linear_model import Lasso
from sklearn.cross_validation import KFold
from sklearn.feature_extraction.text import CountVectorizer, TfidfVectorizer
from sklearn.pipeline import FeatureUnion
import json
import glob
import numpy as np
import pandas as pd
print('try to load jsons')
data = [json.load(open(n)) for n in glob.glob('parsed/*')]
print('finish to load jsons')
para = {
  "analyzer": 'word',
  "token_pattern": r'\w{1,}',
  "sublinear_tf": True,
  "dtype"     : np.float32,
  "norm"      : 'l2',
  "smooth_idf":False
}
def get_col(col_name): return lambda x: x[col_name]
vectorizer = FeatureUnion([
        ('bodies',TfidfVectorizer(
            ngram_range=(1, 1),
            max_features=10000,
            **para,
            preprocessor=get_col('bodies'))),
        ('titles',TfidfVectorizer(
            ngram_range=(1, 1),
            **para,
            max_features=2000,
            preprocessor=get_col('titles')))
    ])
print('fit to tfidf')
vectorizer.fit(data)
print('finish tfidf')

arr  = vectorizer.transform(data).todense()
voc  = vectorizer.get_feature_names()

df   = pd.DataFrame(arr)
df.columns = voc
print(voc)
```

## input format 

```json
{
  "time": "2017/03/10 22:00",
  "titles": "彼氏 の 前 で は にゃんにゃん … … 働き 女子 が 同僚 に 隠し て いる プライベート な 一面 8 選 | ニコニコニュース",
  "bodies": "誰 しも 、 同僚 に は こんな こと 言え ない なぁ と いう こと は たくさん ある の で は ない でしょ う か 。 仕事 の とき の 振る舞い と プライベート で の 振る舞い は ちょっと 違う もの です よ ね 。 今回 は 同僚 に 隠し て いる プライベート で の 一面 について 、 社会人 女性 の みなさん に 質問 し て み まし た 。 ▶ 【 人間力 診断 テスト 
まとめ 】 社会人 に なる 前 に 自分 の 社会 人力 を チェック しよう ■ あなた が 同僚 に は あまり 見せ ない よう に 隠し て いる 、 プライベート で の 一面 は ？ ● 趣味 の こと 
・ 嵐 が 好き 。 アイドル に はまっ て いる と 知ら れ たく ない （ 50歳 以上 ／ その他 ） ・ 趣味 の こと は 内緒 に し て いる 。 仕事 に 関係 の ない こと だ から （ 25歳 ／ 
ホテル ・ 旅行 ・ アミューズメント ） ・ ギャンブル 好き 。 一人 で 休み に パチンコ 行っ て 勝負 を かける （ 47歳 ／ 小売店 ） ● 甘えん坊 ・ 彼氏 の 前 で かなり 甘え て いる 
。 冷やかし に あい そう だ から （ 26歳 ／ 運輸 ・ 倉庫 ） ・ 彼 の 前 で は けっこう 甘え て いる （ 33歳 ／ 学校 ・ 教育 関連 ） ・ 職場 で は 姉御 的 だ が 実は 末っ子 で 甘
えん坊 。 職場 に は 甘え られる よう な 人 が い ない ので （ 43歳 ／ その他 ） ・ 実は にゃんにゃん し て いる が 、 普段 は 隠し て いる 。 仕事 で は できる キャラ だ から （
 30歳 ／ 団体 ・ 公益法人 ・ 官公庁 ） ● だら しない ・ ぐうたら 人間 な こと 。 家で は ぐうたら すごし て い て 、 そんな 姿 は 恥ずかしく て 見せ られ ない から （ 33歳 ／ 食
品 ・ 飲料 ） ・ しっかり し て いる 雰囲気 を 出し て いる けれど 、 家で は ダラダラ 。 職場 の 机 回り は きれい に 整頓 し て いる けれど 、 自宅 は 割 と 散らかっ て いる （
 35歳 ／ 学校 ・ 教育 関連 ） ・ 家 だ と だらし ない 。 会社 で は 几帳面 で 通し て いる ので 信用 が 落ちる （ 32歳 ／ 情報 ・ IT ） ・ 干物 な 姿 （ 22歳 ／ その他 ） ● オタ
ク ・ アニメ 好き 。 照れくさい から （ 41歳 ／ 情報 ・ IT ） ・ オタク 趣味 が ある 。 職場 で は あまり まだ オタク が いい 扱い を さ れ て ない ので （ 24歳 ／ その他 ） ・ 
声優さん が 好き で 追っかけ を し て い た こと が ある 。 偏見 の 目 で 見 られ そうだ から （ 30歳 ／ その他 ） ● その他 ・ 普段 は おとなしく し て いる が 、 本当は しょうも
ない こと が 好き 。 同期 より も 年上 な ので しょう も ない面 は 出せ ない （ 26歳 ／ 医薬品 ・ 化粧品 ） ・ 実は すごく キツイ 性格 で ある こと 。 バレ たら 嫌わ れる から （
 23歳 ／ 金属 ・ 鉄鋼 ・ 化学 ） ・ 家 で 泣い て いる 。 会社 で は 泣け ない から （ 28歳 ／ その他 ） ・ プライベート で は ふざけ て ばかり 。 会社 で は 相当 暗い と 思う （
 47歳 ／ 食品 ・ 飲料 ） 趣味 について は 同僚 に 話し て い ない という 人 が 多く い まし た 。 自分 の 趣味 嗜好 は なかなか オープン に する の が 難しい よう です 。 実は 甘
えん坊 、 実は だら しない といった よう に 、 会社 で は キリッと しっかり し た 雰囲気 を 出し て がんばっ て いる けれど 、 プライベート で は 実は 違う … … という 人 も 少な
く あり ませ ん でし た 。 仕事 で きちんと し て いれ ば 、 プライベート は 少し くらい ダラダラ し た って バチ は あたり ませ ん よ ね 。 文 ・ 学生 の 窓口 編集部 マイナビ 学
生 の 窓口 調べ 調査 期間 ： 2017年 3月 調査 人数 ： 社会人 男女 224人"
}
```
