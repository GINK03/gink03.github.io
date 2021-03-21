---
layout: post
title: "ai explanations"
date: 2021-02-28
excerpt: "説明可能なAIについて"
kaggle: true
hide_from_post: true
tag: ["deep-learning", "ai explanations", "gcp"]
comments: false
---

# 説明可能なAIについて
 - gcpの機能の一つ
 - [docs](https://cloud.google.com/ai-platform/prediction/docs//overview)

 - ***統合勾配方式***
   - Shapley 値と同じ公理プロパティ
   - **適応**
	 - 微分可能なモデル
	 - 画像データ
	 - 分類
	 - 回帰
 - ***XRAI***
   - 統合勾配方式の拡張
	 - クラスタ分けして画像のどの部分が重要なのか計算する
 - ***サンプリングされた Shapley***
   - 微分不可能なときに用いる特徴量重要度
	 - 木構造など
