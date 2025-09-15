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
 - JupyterLab/Jupyter NotebookでLLMを使う機能
   - GitHub Copilotのようにコード補完を行うわけではない
 - `langchain-openai`がなかったり、環境変数がなかったりするとそもそもUI上の選択肢に表示されない

## インストール

```console
$ pip install jupyter-ai jupyter-ai-magics langchain-openai
```

## 使い方

**初期化**
```python
# 環境変数の設定(APIキーの設定)
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
%ai register gpt-5 openai-chat:gpt-5
```

**コードの生成**
```python
%%ai gpt-5 -f code
フィボナッチ数列を計算する関数をお願いします。実行例も含めてください
```

**特定のコードブロックを入力にして文章を生成**
```python
%%ai gpt-5
以下のコードをmatch-case文を使用するようにリファクタリングして
日本語のコメントで改善点を明示して
--
{In[36]}
```
