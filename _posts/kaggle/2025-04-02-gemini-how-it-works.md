---
layout: post
title: "gemini how it works" 
date: 2025-04-02
excerpt: "gemini how it works"
kaggle: true
tag: ["gemini", "gpt", "LLM", "python"]
comments: false
sort_key: "2025-04-02"
update_dates: ["2025-04-02"]
---

# gemini how it works

### フレームの抽出と画像トークン化

 - 1秒あたり1フレーム (1 FPS) の静止画を抽出
 - 各フレームは所定の解像度（最大768×768ピクセル程度）にリサイズ
 - 1フレームは258トークンに変換される
 - 映像フレームのエンコードにはViT系技術（パッチ分割と埋め込み）が用いられている

### 音声トラックの処理と言語化

 - モノラル1kbps相当にまで情報圧縮した上で1秒あたり32個の音声トークンに変換
 - 非音声（環境音）の認識は誤りやすいと報告されている

### 時系列コンテキストとトークン列統合

 - `00:00 (タイムスタンプ7トークン)` + フレーム0の258トークン + 音声0秒の32トークン
 - `00:01 (タイムスタンプ7トークン)` + フレーム1の258トークン + 音声1秒の32トークン
 - `00:02` ... 以下同様

上記のフォーマットで内部的に保存される

### アーキテクチャ

 - Transformer+Mixture-of-Experts (MoE)アーキテクチャ
 - あらゆるモダリティの入力を単一のトークン列として処理

### ChatGPTのDeepResearchによる結果

 - [Gemini 動画インプット処理](https://chatgpt.com/share/67ece27e-66ac-8012-b74b-b49e159b4cf2)
