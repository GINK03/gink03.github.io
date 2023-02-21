---
layout: post
title: "openai cli" 
date: 2023-02-21
excerpt: "openaiのcliの使い方"
kaggle: true
tag: ["openai", "gpt"]
comments: false
sort_key: "2023-02-21"
update_dates: ["2023-02-21"]
---

# openaiのcliの使い方

## 概要
 - モデルのファインチューニングや学習の管理などができる

## インストール

```console
$ python3 -m pip install openai
```

## 認証の通し方
 - 環境変数でシークレットキーを与える 

```console
$ export OPENAI_API_KEY=sk-xxxxxxxxxxxxxxxxxxxxxxxxxx
```

## ファインチューニングのデータセットのフォーマット
 - [/jsonl/](/jsonl/)形式
 - `prompt`と`completion`があることを期待

## データセットのチェックとサニタイズ
 - スペースがあるべき点にない、文の終わりを宣言していないなどを補完する

```console
$ openai tools fine_tunes.prepare_data -f <data.jsonl>
```

## ファインチューニング

```console
$ openai api fine_tunes.create -t "data_prepared.jsonl"
```

## ファインチューニング中・完了のモデルを確認する

```console
$ openai api fine_tunes.list
```

## ファインチューニングしたモデルで推論する

**consoleでの利用**
```console
$ $ openai api completions.create -m <curie:ft-personal-2023-02-21-04-06-05> -p <prompt>
```

---

## 参考
 - [Fine-tuning/openai](https://platform.openai.com/docs/guides/fine-tuning)
