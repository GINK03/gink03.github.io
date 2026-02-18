---
layout: post
title: "Anthropic Container Skills"
date: 2026-02-16
excerpt: "Anthropic Container Skillsの使い方"
kaggle: true
tag: ["anthropic", "python", "API"]
comments: false
sort_key: "2026-02-16"
update_dates: ["2026-02-16"]
---

# Container Skillsとは

 - Container Skillsは、AnthropicがClaude API向けに提供する機能
 - 特定のタスク（PowerPoint、Excel、Word、PDFの作成・編集など）をサーバサイドの隔離されたコンテナ環境で実行する
 - 従来のCode Executionツールとは異なり、Anthropicが用意した事前構築済みの環境とライブラリを使って高度なドキュメント操作を行える

## 主な特徴

 - **サーバサイド実行**: Anthropicのインフラ上でPythonコード（openpyxl、python-pptxなど）が実行されるため ローカル環境の依存関係を気にする必要がない
 - **利用可能なSkills**: PowerPoint（`pptx`） Excel Word PDFなどの公式Skillが提供される
 - **カスタムSkills**: 独自のSkillをMarkdownで定義してアップロードすることもできる

この機能により、複雑なドキュメント生成タスクをClaude APIだけで完結させることができる


## クライアント初期化

```python
from anthropic import Anthropic

client = Anthropic(timeout=60 * 15)
```


## ファイルのアップロード

 - 処理対象のファイル（例 PPTX）をAnthropicのFiles APIにアップロード

```python
uploaded_file = client.beta.files.upload(
    file=open("./example.pptx", "rb"),
    betas=["files-api-2025-04-14"],
)
```


## Container Skillsを使ったメッセージ送信

 - 重要なポイントは `container` パラメータで使用するSkillを指定し `betas` に必要なフラグを追加する

```python
skills = [{"type": "anthropic", "skill_id": "pptx", "version": "latest"}]

betas = [
    "code-execution-2025-08-25",
    "skills-2025-10-02",
    "files-api-2025-04-14",
]

tools = [{"type": "code_execution_20250825", "name": "code_execution"}]

messages = [{
    "role": "user",
    "content": [
        {"type": "text", "text": "スライドを編集してください"},
        {"type": "container_upload", "file_id": uploaded_file.id}
    ]
}]

with client.beta.messages.stream(
    model="claude-sonnet-4-5-20250929",
    max_tokens=64000,
    betas=betas,
    container={"skills": skills},
    tools=tools,
    messages=messages,
) as stream:
    for event in stream:
        if event.type == "content_block_delta":
            print(event.delta.text, end="", flush=True)
    
    resp = stream.get_final_message()
```


## `pause_turn`への対応

 - Container Skills使用時、処理が長時間かかる場合に`stop_reason="pause_turn"`が返されることがある
 - この場合、assistant contentをmessagesに追加して続行

```python
if resp.stop_reason == "pause_turn":
    messages.append({"role": "assistant", "content": resp.content})
    # ループで再度リクエスト
```


## 生成されたファイルのダウンロード

 - レスポンスから`file_id`を抽出し、Files APIでダウンロード

```python
file_ids = extract_file_ids(resp)  # カスタム関数で抽出

for file_id in file_ids:
    binresp = client.beta.files.download(
        file_id=file_id,
        betas=["files-api-2025-04-14"],
    )
    binresp.write_to_file("output.pptx")
```
