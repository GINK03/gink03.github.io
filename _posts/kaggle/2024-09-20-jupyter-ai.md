---
layout: post
title: "jupyter ai"
date: 2024-09-20
excerpt: "jupyter aiの使い方"
tag: ["jupyter", "kaggle", "python"]
comments: false
sort_key: "2024-09-20"
update_dates: ["2024-09-20"]
---

# jupyter aiの使い方

## 概要
 - jupyter lab/notebookでLLMを使う機能
   - github copilotのようにコードコンプリケーションを行うわけではない

## インストール

```console
$ pip install jupyter-ai
```

## 使い方

**初期化**
```python
# 環境変数の設定
%env OPENAI_API_KEY=sk-xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
# extensionの読み込み
%load_ext jupyter_ai
```

**使用可能なモデルの一覧**
```python
%ai list
```

**エイリアスの設定**
```python
# openai-chat:gpt-4oをgpt-4oとして登録
%ai register gpt-4o openai-chat:gpt-4o
```

**コードの生成**
```python
%%ai gpt-4o -f code
フィボナッチ数列を計算する関数をお願いします。実行例も含めてください
```

**特定のコードブロックを入力に文章を生成**
```python
%%ai gpt-4o
以下のコードをmatch case文を使用するようにリファクタリングして
日本語のコメントで改善点を明示して
--
{In[36]}
```
