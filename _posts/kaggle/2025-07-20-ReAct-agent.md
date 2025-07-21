---
layout: post
title: "ReAct agent"
date: 2025-07-20
excerpt: "ReAct agentの概要"
kaggle: true
tag: ["ReAct agent", "LLM", "AI", "Python", "Kaggle"]
comments: false
sort_key: "2025-07-20"
update_dates: ["2025-07-20"]
---

# ReAct agentの概要

## 概要
 - LLMエージェントの基本形の一つ

## フロー
 1. Thought
   - LLMが思考を行う
 2. Action
   - ツールの選択と、ツールの引数の生成(+別システムがツールを実行)
 3. Observation
   - ツールの実行結果を受け取る
 4. Final Answer/Termination
   - 十分ならば停止
   - 十分でなければ、1に戻る

## 参考
 - [ReActエージェントの説明](https://chatgpt.com/share/687ce58e-1278-8012-82b7-766998d9e72c)
