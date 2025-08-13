---
layout: post
title: "open webui"
date: "2025-08-13"
excerpt: "open webuiの使い方"
config: true
tags: ["open webui"]
comments: false
sort_key: "2025-08-13"
update_dates: ["2025-08-13"]
---

# open webuiの使い方

## 概要
 - ローカルLLMや自身のLLMサービスのキーを入力すること(BYOK)でLLMを利用できるサービス
 - openrouterを利用することができるため、様々なLLMを利用できる

## 利用方法
 - 以下の２つ
   - docker
   - pythonの仮想環境

**pythonの仮想環境(uv)**

```console
$ uv init .
$ uv python pin 3.12
$ uv add open-webui
$ uv add google-api-python-client
$ uv run open-webui serve --host 0.0.0.0 --port 8080
```

## 環境変数

```env
DATA_DIR=./data
ENABLE_OPENAI_API=true
OPENAI_API_BASE_URL=https://openrouter.ai/api/v1
OPENAI_API_KEY=sk-or-v1-*********** # OpenRouterのAPIキーを入力
# リソース制限を無効化
CODE_EVAL_VALVE_OVERRIDE_REQUIRE_RESOURCE_LIMITING=false
CODE_EVAL_VALVE_OVERRIDE_MAX_RAM_MEGABYTES=0
```

## tool, functionの導入
 - `管理者パネル` -> `Functions` -> マーケットプレイスからダウンロード

