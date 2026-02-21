---
layout: post
title: "Spec Driven Development SDD"
date: 2026-02-26
excerpt: "仕様を中心に据えて AI エージェント開発を進める SDD の要点"
computer_science: true
tag: ["spec driven development", "sdd"]
comments: false
sort_key: "2026-02-26"
update_dates: ["2026-02-26"]
---

# Spec Driven Development SDD

## 概要

 - ソフトウェアの仕様を中心に据えた開発手法
 - 特に AI エージェントを用いた開発で効く
 - 仕様が成果物であり、実装は仕様を満たす手段として扱う

## ねらい

 - 期待する振る舞いを先に固定して、実装の迷いと手戻りを減らす
 - 受け入れ条件を明確にして、レビューと検証を速くする
 - AI エージェントの出力を仕様で拘束して、暴走と過剰実装を防ぐ

## Claude Code や Codex を用いた SDD のプロセス

 - `.ai/specs/<NNN>-<feature>/spec.md` に仕様

 1. `spec.md` に仕様を書く
 2. 仕様からタスク分解する
 3. 実装する
 4. テストと検証を回す
 5. 仕様と実装を同期して完了にする


## 仕様に含めたい項目

 - スコープ
 - ユーザーストーリー
 - 機能要件
 - 受け入れ条件
 - 制約と非機能要件
 - やらないこと

## 最低限の spec.md テンプレ

```md
# <Feature 名>

## 背景

## スコープ

## ユーザーストーリー

## 機能要件

## 受け入れ条件

## 制約と非機能要件

## やらないこと
```
