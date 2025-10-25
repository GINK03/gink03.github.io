---
layout: post
title: "Claude Agent Skills"
date: 2025-10-25
excerpt: "Claude Agent Skills の使い方"
config: true
tag: ["Claude Agent SDK", "agent skills"]
comments: false
sort_key: "2025-10-25"
update_dates: ["2025-10-25"]
---

# Claude Agent Skills の使い方

## 概要
 - Anthropic が提唱するプロンプト手法のひとつ
 - 特定のディレクトリとファイル構成で、再現可能なプロンプト機能を提供する
 - すべての情報を `CLAUDE.md` に入れるよりも、メンテナンス性・再利用性・共有性が高い

## 構造

```text
プロジェクトルート/
└── .claude/
    └── skills/
        ├── skill-name-1/
        │   ├── SKILL.md          # 必須
        │   ├── scripts/          # オプション
        │   │   └── helper.py
        │   └── templates/        # オプション
        │       └── template.txt
        └── skill-name-2/
            └── SKILL.md
```

## `SKILL.md` の記述

```text
---
name: your-skill-name
description: この Skill が何をするか、いつ使うべきかの簡潔な説明
---

# Your Skill Name

## Instructions

Claude への明確な手順をステップバイステップで記述します。

## Examples

具体的な使用例を示します。
```

 - `name`: 小文字・数字・ハイフンのみ使用可（最大64文字）
 - `description`: Skill の説明（最大1024文字）

### サポートファイル
 - Python スクリプトなどの実行可能ファイル
 - テンプレートファイル
 - 参考資料やドキュメント
