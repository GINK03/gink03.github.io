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
 - コードの編集に限ると、Web版のChatGPTよりも優れている
 - `ctrl + j` で改行
 - `ctrl + d` で終了

## 特徴
 - 大きなファイルはスライディングしながら読み込む
 - 出力が大きく、1ページに収まりきらない場合は、tmuxのスクロールモードを利用する等で確認できる
 - `esc` を二回連続押すことで編集作業を中断できる

## インストール

**npm**
```console
$ npm install -g @openai/codex
```

**bun**
```console
$ bun install -g @openai/codex
```

## 環境変数でキーを渡す

```console
$ export OPENAI_API_KEY=sk-...
```

## 実行

```console
$ codex --model codex-mini-latest
```

## インストラクション
 - `~/.codex/instructions.md`: グローバル設定
 - `AGENTS.md`: プロジェクトルートに置くことでプロジェクト固有の設定

### インストラクションの例

```text
# プロジェクトの説明
 - このプロジェクトはブログのマークダウン管理します
 - エージェントの目的はブログの指定されたコンテンツの不備を修正することです

## 構造の説明
 - `_posts/<subdir>` 以下に個々のmarkdownコンテンツが配置されている
 - `<subdir>`はコンテンツの性質に応じて作成されている

## 遵守事項
 - `git restore .` を絶対行わない
```

## 設定
 - `~/.codex/config.yaml`: 設定ファイルの場所

```yaml
model: codex-mini-latest
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

## codexが苦手なこと
 - 同じようなコードの関数が複数あると、指定した関数と別の関数を修正してしまう
   - コマンドでスライドして読み込んでいるためだと考えられる

## トラブルシューティング
 - ネットワークに問題が無いのに、エラーで処理が止まる場合
   - 原因
     - どうやら `{` が二回連続している or `[{` などの特殊な構文があると、codexがエラーを起こすことがある
   - 対応
     - jinja2のテンプレートで`Environment(variable_start_string='[[', variable_end_string=']]', autoescape=False)` を使う

## 参考
 - [github.com/openai/codex](https://github.com/openai/codex)
