---
layout: post
title: "openai codex cli"
date: 2025-04-20
excerpt: "openai codex cliの使い方"
config: true
tag: ["openai", "codex", "cli"]
comments: false
sort_key: "2025-04-20"
update_dates: ["2025-04-20"]
---

# openai codex cliの使い方

## 概要
 - openaiが開発したterminalで動作するコーディングサポートエージェント
 - 2023年時点のcodex(コード補完AI)とは別物

## 特徴
 - 大きなファイルはスライディングしながら読み込む
 - 出力が大きく、1ページに収まりきらない場合は、tmuxのスクロールモードを利用する等で確認できる
 - `esc` を二回連続押すことで編集作業を中断できる

## インストール

```console
$ npm install -g @openai/codex
```

## 環境変数でキーを渡す

```console
$ export OPENAI_API_KEY=sk-...
```

## インストラクション
 - `~/.codex/instructions.md`: グローバル設定
 - `project/codex.md`: プロジェクト独自設定

## 設定
 - `~/.codex/config.yaml`: 設定ファイルの場所

```yaml
model: o4-mini
approvalMode: suggest
fullAutoErrorMode: ask-user
notify: true
safeCommands:
  - npm test
  - yarn lint
```

## 破壊的変更を防ぐ
 - ブランチを切る
 - `git add . && git commit -m 'before codex'` でコミット
 - codexを実行
 - おかしくなったら `git reset --hard HEAD` で戻す

## 対話モードでよく使うプロンプト 
 - `foo.py で何をやっているか教えて`
 - `src/* を読み込んでどのようなことを行うコードなのか教えて`
 - `ありがとう、今までの改善すべき点をまとめて codex-review.md に書き出して`

## 参考
 - [github.com/openai/codex](https://github.com/openai/codex)
