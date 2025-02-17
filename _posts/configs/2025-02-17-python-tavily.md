---
layout: post
title: "python tavily"
date: 2025-02-17
excerpt: "python tavilyの使い方"
config: true
tag: ["python", "tavily"]
comments: false
sort_key: "2025-02-17"
update_dates: ["2025-02-17"]
---

# python tavilyの使い方

## 概要
 - LLM用の検索を行うためのツール
 - `search_depth`を指定することで、検索の深さを指定できる(らしいが、日本語のクエリで変化が見られなかった)

## インストール

```console
$ pip install tavily-python
```

## 使い方

**基本**
```python
from tavily import TavilyClient
client = TavilyClient(api_key="tvly-dev-********")

response = client.search(query="葛飾区のおすすめのラーメンは?")
response
"""
{'query': '葛飾区のおすすめのラーメンは?',
 'follow_up_questions': None,
 'answer': None,
 'images': [],
 'results': [{'title': '「葛飾区で人気のラーメン」ランキングTOP20! 1位は「麺心 國もと」【2023年12月版／Googleクチコミ調べ】',
   'url': 'https://nlab.itmedia.co.jp/research/articles/2095480/',
   'content': '第2位は葛飾区立石の「一力」でした。京成電鉄押上線「京成立石駅」の徒歩圏内にあるお店です。店内にはカウンター席が用意されており',
   'score': 0.9159971,
   'raw_content': None},
  {'title': '【保存版】葛飾でラーメンならここ!ラーメン好き筆者おすすめの15選【リーズナブル・あっさり・こってり・個性派など】',
   'url': 'https://anniversarys-mag.jp/178718',
   'content': '千葉県と隣接する、東京都葛飾区。東京の端っこの下町というイメージが強いですが、実は亀有や新小岩を中心においしいラーメン屋が多く集まります。有名店や人気店も多く、ラーメン目的で足を運びたくなってしまうエリアですよ。 今回はラーメン好き筆者が、葛飾でおすすめのラーメン',
   'score': 0.8914433,
   'raw_content': None},
  {'title': '「葛飾区で人気のラーメン」ランキングTOP20! 1位は「麺心 國もと」【2025年1月版／Googleクチコミ】',
   'url': 'https://nlab.itmedia.co.jp/research/articles/3145344/',
   'content': '東京では多くの人気ラーメン店があり、それぞれの味を磨いています。下町エリアと呼ばれる葛飾区でも人気のお店が数多く存在します。そこで',
   'score': 0.8773195,
   'raw_content': None},
  {'title': '葛飾区のラーメンランキングTOP10 - じゃらんnet',
   'url': 'https://www.jalan.net/gourmet/cit_131220000/g2_3g130/',
   'content': '葛飾区のおすすめラーメン145ヶ所をセレクト!おすすめのラーメン燈郎やつけ麺 道などを口コミランキングでご紹介。 葛飾区のラーメンスポットを探すならじゃらんnet。 ... 12時前に着いてチケットを買うのに先客は5人もすぐに購入出来て12',
   'score': 0.8740022,
   'raw_content': None},
  {'title': '「葛飾区で人気のラーメン」ランキングTOP20! 1位は「麺心 國もと」【2024年11月版／Googleクチコミ】',
   'url': 'https://nlab.itmedia.co.jp/research/articles/3107717/',
   'content': 'そんな東京都葛飾区で人気のラーメン店を探している人に向けて、Googleマップ上で人気のお店を紹介します。 なおこのランキングは、Googleマップ',
   'score': 0.8727061,
   'raw_content': None}],
 'response_time': 2.74}
"""

response = client.search(query="葛飾区のおすすめのラーメンは?", search_depth="advanced")
response
```

**QNA**
```python
response = client.qna_search(query="葛飾区のおすすめのラーメンは?")
response
"""
'葛飾区のおすすめラーメン店は「麺心 國もと」で、店主は「麺屋武蔵」出身でメニューに「らーめん」「塩らーめん」「醤油まぜそば」など種類が豊富です。また、「鴨出汁中華蕎麦 麺屋yoshiki」や「らーめん 味噌ガッツ」も人気があります。'
"""
```

## 参考
 - [tavily-ai/tavily-python - GitHub](https://github.com/tavily-ai/tavily-python)
