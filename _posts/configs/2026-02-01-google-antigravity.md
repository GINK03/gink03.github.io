---
layout: post
title: "Google Antigravity"
date: 2026-02-01
excerpt: "GoogleがリリースしたAIエージェント型IDE「Antigravity」について"
config: true
tag: ["google", "ai", "ide", "agent", "gemini"]
comments: false
sort_key: "2026-02-01"
update_dates: ["2026-02-01"]
---

# Google Antigravity

## 概要
 - 2025年11月にGoogleがリリースした、**AIエージェント駆動型**の統合開発環境 (IDE)
 - 従来の「人間がコードを書く」スタイルから、「AIエージェントにタスクを指示して実装させる」**Agent-First Development** へのシフトを掲げている
 - VS CodeベースのUI

## 特徴

### Gemini 3 Pro 搭載
 - バックエンドには、コーディングと推論に最適化された最新モデル **Gemini 3 Pro** を採用
 - 大規模なコンテキスト理解と、複数ステップにわたる計画立案（Multi-step Planning）が可能

### Agent Manager と Multi-agent System
 - 開発者は「認証機能を実装して」といったゴールを提示する
 - 複数の専門エージェント（コーディング担当、テスト担当、リファクタリング担当など）が協調してタスクを遂行する
 - エージェントは自律的に計画、コード生成、実行、修正のループを回す

### Built-in Browser & Validation
 - IDE内にブラウザが内蔵されており、Webアプリの動作確認までエージェントが自動で行う
 - ブラウザ操作用のサブエージェントがChromeを立ち上げ、UIのテストやデバッグを実行する

### Antigravity Skills
 - エージェントに特定のドメイン知識やワークフローを追加するための仕組み
 - サーバーレスかつファイルベースの定義で、プロジェクト固有のルールやツールの使い方を学習させることができる

## 使ってみた感想
 - 保守的に使用するならば、cursorとほぼ同じ使い勝手
   - 選択して `CMD + i` で選択範囲のAI編集が可能

## 参考
 - [Google Antigravity - Official Site](https://antigravity.google/)
 - [Introducing Google Antigravity: The Agent-First IDE](https://blog.google/technology/developers/antigravity-launch)
